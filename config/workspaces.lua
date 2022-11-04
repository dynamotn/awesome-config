local M = {
  term = 'TERM',
  web = 'WEB',
  mail = 'MAIL',
  media = 'M&V',
  chat = 'CHAT',
  doc = 'DOC',
  game = 'GAME',
  sys = 'SYS',
  other = 'MORE',
}
if screen.count() == 1 then
  M.list = {
    {
      M.term,
      M.web,
      M.media,
      M.chat,
      M.doc,
      M.game,
      M.sys,
      M.other,
    },
  }
elseif screen.count() == 2 then
  M.list = {
    {
      M.term,
      M.doc,
      M.chat,
      M.media,
    },
    {
      M.web,
      M.sys,
      M.other,
    },
  }
end

return M
