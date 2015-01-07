parsePostData = (query)->
  result = {}
  query.split("&").forEach (part)->
    item = part.split("=")
    result[item[0]] = decodeURIComponent(item[1])
  result

`export default parsePostData`