module ToolKit
  def paginate_anything
    start, _end = 0, 100
    start, _end = headers['Range'].split('-') if (headers['Range'])
    data, count = yield(start.to_i, _end.to_i)
    header 'Accept-Ranges', 'items'
    header 'Range-Unit', 'items'
    header 'Content-Range', "#{start}-#{start.to_i+data.count-1}/#{count}"
    data
  end

  def paginate_result (data, count, start)
    {
        data: data,
        count: count,
        start: start,
        end: start.to_i+data.count-1
    }
  end

  def require_authorized!
    error!({message: '请先登录后再试！'}.as_json, 403) unless @current_user
    error!({message: '此领域登录的帐号不匹配！故无权限！'}.as_json, 403) if @space_user.id != @current_user.id
  end

  def require_admin!
    error!({message: '需要超级权限！'}.as_json, 403) unless @current_user&&@current_user.admin
  end

  def auth_with_cookie_or_header
    User.auth_with_cookie(cookies) || User.auth_with_header(headers)
  end

  def cors_request
    if headers['Referer']
      env[:require_domain] = require_domain = headers['Referer']
      header 'Access-Control-Allow-Origin', require_domain[0...require_domain.to_s.index(?/, 7)]
    end
  end

  def cors_response
    headers = {}
    if env[:require_domain]
      require_domain = env[:require_domain]
      headers['Access-Control-Allow-Origin'] = require_domain[0...require_domain.to_s.index(?/, 7)]
    end
    headers
  end
end