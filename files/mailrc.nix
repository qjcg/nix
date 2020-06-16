{ secrets, ... }:

''
  set v15-compat
  set sendcharsets=utf-8
  set sendwait
  set noheader
  set noasksend

  define InboxHook {
  	search :fu
  }
  set folder-hook-+INBOX=InboxHook

  ${secrets.s-nail-accounts}
''
