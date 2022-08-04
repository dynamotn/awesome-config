local M = {
  term = 'TERM',
  web = 'WEB',
  mail = 'MAIL',
  music = 'M&V',
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
      M.mail,
      M.music,
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
      M.web,
      M.mail,
      M.doc,
      M.chat,
      M.music,
    },
    {
      M.term,
      M.sys,
      M.other,
    },
  }
end

return M
