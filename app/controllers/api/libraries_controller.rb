class Api::LibrariesController < ApplicationController
  def show
    @libraries = Library.joins(:users).where({users: {id: params[:id]}})
  end

  def create
    # 図書館APIを叩く部分
    uri = URI.parse("http://api.calil.jp/library?#{query_params}")
    logger.debug(uri)
    # logger.debug(params[:uid])
    begin
      response = Net::HTTP.start(uri.host, uri.port) do |http|
        http.get(uri.request_uri)
      end
      case response
      when Net::HTTPSuccess
        # 帰ってくる図書館jsonが、`[{...}]);`と言う訳のわからない形で送られてくるため後ろを削除
        @libraries_api = JSON.parse(response.body.delete(');'))
        # logger.debug(@libraries_api)
        else
        # エラーハンドリング
        logger.error("HTTP ERROR: code=#{response.code} message=#{response.message}")
      end
    end
    @libids = []
    # 図書館テーブルに追加していく部分
    @libraries_api.each do |lib|
      # API叩いてもらった図書館 in 図書館モデルをどうやって取り出すかわからなかった
      # なので、図書館idをいったん保存しておいてそのlibidが一致するものを図書館情報から引っ張っている
      @libids.push(lib["libid"])
      # もしLibraryのlibidカラムにlibが存在しないならtrue
      if Library.find_by(libid: lib["libid"]).nil?
        lng,lat = lib["geocode"].split(",")
        @library = Library.new(
            name: lib["formal"],
            systemid: lib["systemid"],
            libid: lib["libid"],
            latitude: lat.to_f,
            longitude: lng.to_f,
            category: lib["category"],
            libkey: lib["libkey"]
        )
        @library.save
      end
    end

    @libraries = Library.where(libid: @libids)
    logger.debug(@libraries)
    render :show, status: :created
  end

  private
  def query_params
    # 送られてくるパラメーターを図書館apiを送るクエリパラメータに変換
    URI.encode_www_form({appkey: ENV['BOOKS_API_KEY'],
            geocode:"#{UserAddition.find(params[:uid]).longitude},#{UserAddition.find(params[:uid]).latitude}",
            format:"json", callback: "no", limit:"20"})
    end
end
