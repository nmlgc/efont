; Copyright (c) 1990-2003
;	Wada Laboratory, the University of Tokyo. All rights reserved.
; Copyright (c) 2003-2004
;	Electronic Font Open Laboratory (/efont/). All rights reserved.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions
; are met:
; 1. Redistributions of source code must retain the above copyright notice,
;    this list of conditions and the following disclaimer.
; 2. Redistributions in binary form must reproduce the above copyright notice,
;    this list of conditions and the following disclaimer in the documentation
;    and/or other materials provided with the distribution.
; 3. Neither the name of the Wada Laboratory, the University of Tokyo nor
;    the names of its contributors may be used to endorse or promote products
;    derived from this software without specific prior written permission.
;
; THIS SOFTWARE IS PROVIDED BY WADA LABORATORY, THE UNIVERSITY OF TOKYO AND
; CONTRIBUTORS ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
; NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
; PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE LABORATORY OR
; CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
; EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
; PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
; WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
; OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
; ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;
; $Id$

(setq jis21 '(¡¡ ¡¢ ¡£ ¡¤ ¡¥ ¡¦ ¡§ ¡¨ ¡© ¡ª ¡« ¡¬ ¡­ ¡® ¡¯ ¡° ¡± ¡² ¡³ ¡´ ¡µ ¡¶ ¡· ¡¸ ¡¹ ¡º ¡» ¡¼ ¡½ ¡¾ ¡¿ ¡À ¡Á ¡Â ¡Ã ¡Ä ¡Å ¡Æ ¡Ç ¡È ¡É ¡Ê ¡Ë ¡Ì ¡Í ¡Î ¡Ï ¡Ð ¡Ñ ¡Ò ¡Ó ¡Ô ¡Õ ¡Ö ¡× ¡Ø ¡Ù ¡Ú ¡Û ¡Ü ¡Ý ¡Þ ¡ß ¡à ¡á ¡â ¡ã ¡ä ¡å ¡æ ¡ç ¡è ¡é ¡ê ¡ë ¡ì ¡í ¡î ¡ï ¡ð ¡ñ ¡ò ¡ó ¡ô ¡õ ¡ö ¡÷ ¡ø ¡ù ¡ú ¡û ¡ü ¡ý ¡þ ))
(setq jis22 '(¢¡ ¢¢ ¢£ ¢¤ ¢¥ ¢¦ ¢§ ¢¨ ¢© ¢ª ¢« ¢¬ ¢­ ¢®  ¢º ¢» ¢¼ ¢½ ¢¾ ¢¿ ¢À ¢Á ¢Ê ¢Ë ¢Ì ¢Í ¢Î ¢Ï ¢Ð  ¢Ü ¢Ý ¢Þ ¢ß ¢à ¢á ¢â ¢ã ¢ä ¢å ¢æ ¢ç ¢è ¢é ¢ê ¢ò ¢ó ¢ô ¢õ ¢ö ¢÷ ¢ø ¢ù ¢þ ))
(setq jis23 '(£° £± £² £³ £´ £µ £¶ £· £¸ £¹ £Á £Â £Ã £Ä £Å £Æ £Ç £È £É £Ê £Ë £Ì £Í £Î £Ï £Ð £Ñ £Ò £Ó £Ô £Õ £Ö £× £Ø £Ù £Ú £á £â £ã £ä £å £æ £ç £è £é £ê £ë £ì £í £î £ï £ð £ñ £ò £ó £ô £õ £ö £÷ £ø £ù £ú))
(setq jis24 '(¤¡ ¤¢ ¤£ ¤¤ ¤¥ ¤¦ ¤§ ¤¨ ¤© ¤ª ¤« ¤¬ ¤­ ¤® ¤¯ ¤° ¤± ¤² ¤³ ¤´ ¤µ ¤¶ ¤· ¤¸ ¤¹ ¤º ¤» ¤¼ ¤½ ¤¾ ¤¿ ¤À ¤Á ¤Â ¤Ã ¤Ä ¤Å ¤Æ ¤Ç ¤È ¤É ¤Ê ¤Ë ¤Ì ¤Í ¤Î ¤Ï ¤Ð ¤Ñ ¤Ò ¤Ó ¤Ô ¤Õ ¤Ö ¤× ¤Ø ¤Ù ¤Ú ¤Û ¤Ü ¤Ý ¤Þ ¤ß ¤à ¤á ¤â ¤ã ¤ä ¤å ¤æ ¤ç ¤è ¤é ¤ê ¤ë ¤ì ¤í ¤î ¤ï ¤ð ¤ñ ¤ò ¤ó))
(setq jis25 '(¥¡ ¥¢ ¥£ ¥¤ ¥¥ ¥¦ ¥§ ¥¨ ¥© ¥ª ¥« ¥¬ ¥­ ¥® ¥¯ ¥° ¥± ¥² ¥³ ¥´ ¥µ ¥¶ ¥· ¥¸ ¥¹ ¥º ¥» ¥¼ ¥½ ¥¾ ¥¿ ¥À ¥Á ¥Â ¥Ã ¥Ä ¥Å ¥Æ ¥Ç ¥È ¥É ¥Ê ¥Ë ¥Ì ¥Í ¥Î ¥Ï ¥Ð ¥Ñ ¥Ò ¥Ó ¥Ô ¥Õ ¥Ö ¥× ¥Ø ¥Ù ¥Ú ¥Û ¥Ü ¥Ý ¥Þ ¥ß ¥à ¥á ¥â ¥ã ¥ä ¥å ¥æ ¥ç ¥è ¥é ¥ê ¥ë ¥ì ¥í ¥î ¥ï ¥ð ¥ñ ¥ò ¥ó ¥ô ¥õ ¥ö))
(setq jis26 '(¦¡ ¦¢ ¦£ ¦¤ ¦¥ ¦¦ ¦§ ¦¨ ¦© ¦ª ¦« ¦¬ ¦­ ¦® ¦¯ ¦° ¦± ¦² ¦³ ¦´ ¦µ ¦¶ ¦· ¦¸¦Á ¦Â ¦Ã ¦Ä ¦Å ¦Æ ¦Ç ¦È ¦É ¦Ê ¦Ë ¦Ì ¦Í ¦Î ¦Ï ¦Ð ¦Ñ ¦Ò ¦Ó ¦Ô ¦Õ ¦Ö ¦× ¦Ø))
(setq jis27 '(§¡ §¢ §£ §¤ §¥ §¦ §§ §¨ §© §ª §« §¬ §­ §® §¯ §° §± §² §³ §´ §µ §¶ §· §¸ §¹ §º §» §¼ §½ §¾ §¿ §À §Á §Ñ §Ò §Ó §Ô §Õ §Ö §× §Ø §Ù §Ú §Û §Ü §Ý §Þ §ß §à §á §â §ã §ä §å §æ §ç §è §é §ê §ë §ì §í §î §ï §ð §ñ))
(setq jis28 '(¨¡ ¨¢ ¨£ ¨¤ ¨¥ ¨¦ ¨§ ¨¨ ¨© ¨ª ¨« ¨¬ ¨­ ¨® ¨¯ ¨° ¨± ¨² ¨³ ¨´ ¨µ ¨¶ ¨· ¨¸ ¨¹ ¨º ¨» ¨¼ ¨½ ¨¾ ¨¿ ¨À))
(setq jis30 '(°¡ °¢ °£ °¤ °¥ °¦ °§ °¨ °© °ª °« °¬ °­ °® °¯ °° °± °² °³ °´ °µ 
              °¶ °· °¸ °¹ °º °» °¼ °½ °¾ °¿ °À °Á °Â °Ã °Ä °Å °Æ °Ç °È °É °Ê 
              °Ë °Ì °Í °Î °Ï °Ð °Ñ °Ò °Ó °Ô °Õ °Ö °× °Ø °Ù °Ú °Û °Ü °Ý °Þ °ß 
              °à °á °â °ã °ä °å °æ °ç °è °é °ê °ë °ì °í °î °ï °ð °ñ °ò °ó °ô 
              °õ °ö °÷ °ø °ù °ú °û °ü °ý °þ))
(setq jis31 '(±¡ ±¢ ±£ ±¤ ±¥ ±¦ ±§ ±¨ ±© ±ª ±« ±¬ ±­ ±® ±¯ ±° ±± ±² ±³ ±´ ±µ 
              ±¶ ±· ±¸ ±¹ ±º ±» ±¼ ±½ ±¾ ±¿ ±À ±Á ±Â ±Ã ±Ä ±Å ±Æ ±Ç ±È ±É ±Ê 
              ±Ë ±Ì ±Í ±Î ±Ï ±Ð ±Ñ ±Ò ±Ó ±Ô ±Õ ±Ö ±× ±Ø ±Ù ±Ú ±Û ±Ü ±Ý ±Þ ±ß 
              ±à ±á ±â ±ã ±ä ±å ±æ ±ç ±è ±é ±ê ±ë ±ì ±í ±î ±ï ±ð ±ñ ±ò ±ó ±ô 
              ±õ ±ö ±÷ ±ø ±ù ±ú ±û ±ü ±ý ±þ))
(setq jis32 '(²¡ ²¢ ²£ ²¤ ²¥ ²¦ ²§ ²¨ ²© ²ª ²« ²¬ ²­ ²® ²¯ ²° ²± ²² ²³ ²´ ²µ 
              ²¶ ²· ²¸ ²¹ ²º ²» ²¼ ²½ ²¾ ²¿ ²À ²Á ²Â ²Ã ²Ä ²Å ²Æ ²Ç ²È ²É ²Ê 
              ²Ë ²Ì ²Í ²Î ²Ï ²Ð ²Ñ ²Ò ²Ó ²Ô ²Õ ²Ö ²× ²Ø ²Ù ²Ú ²Û ²Ü ²Ý ²Þ ²ß 
              ²à ²á ²â ²ã ²ä ²å ²æ ²ç ²è ²é ²ê ²ë ²ì ²í ²î ²ï ²ð ²ñ ²ò ²ó ²ô 
              ²õ ²ö ²÷ ²ø ²ù ²ú ²û ²ü ²ý ²þ))
(setq jis33 '(³¡ ³¢ ³£ ³¤ ³¥ ³¦ ³§ ³¨ ³© ³ª ³« ³¬ ³­ ³® ³¯ ³° ³± ³² ³³ ³´ ³µ 
              ³¶ ³· ³¸ ³¹ ³º ³» ³¼ ³½ ³¾ ³¿ ³À ³Á ³Â ³Ã ³Ä ³Å ³Æ ³Ç ³È ³É ³Ê 
              ³Ë ³Ì ³Í ³Î ³Ï ³Ð ³Ñ ³Ò ³Ó ³Ô ³Õ ³Ö ³× ³Ø ³Ù ³Ú ³Û ³Ü ³Ý ³Þ ³ß 
              ³à ³á ³â ³ã ³ä ³å ³æ ³ç ³è ³é ³ê ³ë ³ì ³í ³î ³ï ³ð ³ñ ³ò ³ó ³ô 
              ³õ ³ö ³÷ ³ø ³ù ³ú ³û ³ü ³ý ³þ))
(setq jis34 '(´¡ ´¢ ´£ ´¤ ´¥ ´¦ ´§ ´¨ ´© ´ª ´« ´¬ ´­ ´® ´¯ ´° ´± ´² ´³ ´´ ´µ 
              ´¶ ´· ´¸ ´¹ ´º ´» ´¼ ´½ ´¾ ´¿ ´À ´Á ´Â ´Ã ´Ä ´Å ´Æ ´Ç ´È ´É ´Ê 
              ´Ë ´Ì ´Í ´Î ´Ï ´Ð ´Ñ ´Ò ´Ó ´Ô ´Õ ´Ö ´× ´Ø ´Ù ´Ú ´Û ´Ü ´Ý ´Þ ´ß 
              ´à ´á ´â ´ã ´ä ´å ´æ ´ç ´è ´é ´ê ´ë ´ì ´í ´î ´ï ´ð ´ñ ´ò ´ó ´ô 
              ´õ ´ö ´÷ ´ø ´ù ´ú ´û ´ü ´ý ´þ))
(setq jis35 '(µ¡ µ¢ µ£ µ¤ µ¥ µ¦ µ§ µ¨ µ© µª µ« µ¬ µ­ µ® µ¯ µ° µ± µ² µ³ µ´ µµ 
              µ¶ µ· µ¸ µ¹ µº µ» µ¼ µ½ µ¾ µ¿ µÀ µÁ µÂ µÃ µÄ µÅ µÆ µÇ µÈ µÉ µÊ 
              µË µÌ µÍ µÎ µÏ µÐ µÑ µÒ µÓ µÔ µÕ µÖ µ× µØ µÙ µÚ µÛ µÜ µÝ µÞ µß 
              µà µá µâ µã µä µå µæ µç µè µé µê µë µì µí µî µï µð µñ µò µó µô 
              µõ µö µ÷ µø µù µú µû µü µý µþ))
(setq jis36 '(¶¡ ¶¢ ¶£ ¶¤ ¶¥ ¶¦ ¶§ ¶¨ ¶© ¶ª ¶« ¶¬ ¶­ ¶® ¶¯ ¶° ¶± ¶² ¶³ ¶´ ¶µ 
              ¶¶ ¶· ¶¸ ¶¹ ¶º ¶» ¶¼ ¶½ ¶¾ ¶¿ ¶À ¶Á ¶Â ¶Ã ¶Ä ¶Å ¶Æ ¶Ç ¶È ¶É ¶Ê 
              ¶Ë ¶Ì ¶Í ¶Î ¶Ï ¶Ð ¶Ñ ¶Ò ¶Ó ¶Ô ¶Õ ¶Ö ¶× ¶Ø ¶Ù ¶Ú ¶Û ¶Ü ¶Ý ¶Þ ¶ß 
              ¶à ¶á ¶â ¶ã ¶ä ¶å ¶æ ¶ç ¶è ¶é ¶ê ¶ë ¶ì ¶í ¶î ¶ï ¶ð ¶ñ ¶ò ¶ó ¶ô 
              ¶õ ¶ö ¶÷ ¶ø ¶ù ¶ú ¶û ¶ü ¶ý ¶þ))
(setq jis37 '(·¡ ·¢ ·£ ·¤ ·¥ ·¦ ·§ ·¨ ·© ·ª ·« ·¬ ·­ ·® ·¯ ·° ·± ·² ·³ ·´ ·µ 
              ·¶ ·· ·¸ ·¹ ·º ·» ·¼ ·½ ·¾ ·¿ ·À ·Á ·Â ·Ã ·Ä ·Å ·Æ ·Ç ·È ·É ·Ê 
              ·Ë ·Ì ·Í ·Î ·Ï ·Ð ·Ñ ·Ò ·Ó ·Ô ·Õ ·Ö ·× ·Ø ·Ù ·Ú ·Û ·Ü ·Ý ·Þ ·ß 
              ·à ·á ·â ·ã ·ä ·å ·æ ·ç ·è ·é ·ê ·ë ·ì ·í ·î ·ï ·ð ·ñ ·ò ·ó ·ô 
              ·õ ·ö ·÷ ·ø ·ù ·ú ·û ·ü ·ý ·þ))
(setq jis38 '(¸¡ ¸¢ ¸£ ¸¤ ¸¥ ¸¦ ¸§ ¸¨ ¸© ¸ª ¸« ¸¬ ¸­ ¸® ¸¯ ¸° ¸± ¸² ¸³ ¸´ ¸µ 
              ¸¶ ¸· ¸¸ ¸¹ ¸º ¸» ¸¼ ¸½ ¸¾ ¸¿ ¸À ¸Á ¸Â ¸Ã ¸Ä ¸Å ¸Æ ¸Ç ¸È ¸É ¸Ê 
              ¸Ë ¸Ì ¸Í ¸Î ¸Ï ¸Ð ¸Ñ ¸Ò ¸Ó ¸Ô ¸Õ ¸Ö ¸× ¸Ø ¸Ù ¸Ú ¸Û ¸Ü ¸Ý ¸Þ ¸ß 
              ¸à ¸á ¸â ¸ã ¸ä ¸å ¸æ ¸ç ¸è ¸é ¸ê ¸ë ¸ì ¸í ¸î ¸ï ¸ð ¸ñ ¸ò ¸ó ¸ô 
              ¸õ ¸ö ¸÷ ¸ø ¸ù ¸ú ¸û ¸ü ¸ý ¸þ))
(setq jis39 '(¹¡ ¹¢ ¹£ ¹¤ ¹¥ ¹¦ ¹§ ¹¨ ¹© ¹ª ¹« ¹¬ ¹­ ¹® ¹¯ ¹° ¹± ¹² ¹³ ¹´ ¹µ 
              ¹¶ ¹· ¹¸ ¹¹ ¹º ¹» ¹¼ ¹½ ¹¾ ¹¿ ¹À ¹Á ¹Â ¹Ã ¹Ä ¹Å ¹Æ ¹Ç ¹È ¹É ¹Ê 
              ¹Ë ¹Ì ¹Í ¹Î ¹Ï ¹Ð ¹Ñ ¹Ò ¹Ó ¹Ô ¹Õ ¹Ö ¹× ¹Ø ¹Ù ¹Ú ¹Û ¹Ü ¹Ý ¹Þ ¹ß 
              ¹à ¹á ¹â ¹ã ¹ä ¹å ¹æ ¹ç ¹è ¹é ¹ê ¹ë ¹ì ¹í ¹î ¹ï ¹ð ¹ñ ¹ò ¹ó ¹ô 
              ¹õ ¹ö ¹÷ ¹ø ¹ù ¹ú ¹û ¹ü ¹ý ¹þ))
(setq jis3a '(º¡ º¢ º£ º¤ º¥ º¦ º§ º¨ º© ºª º« º¬ º­ º® º¯ º° º± º² º³ º´ ºµ 
              º¶ º· º¸ º¹ ºº º» º¼ º½ º¾ º¿ ºÀ ºÁ ºÂ ºÃ ºÄ ºÅ ºÆ ºÇ ºÈ ºÉ ºÊ 
              ºË ºÌ ºÍ ºÎ ºÏ ºÐ ºÑ ºÒ ºÓ ºÔ ºÕ ºÖ º× ºØ ºÙ ºÚ ºÛ ºÜ ºÝ ºÞ ºß 
              ºà ºá ºâ ºã ºä ºå ºæ ºç ºè ºé ºê ºë ºì ºí ºî ºï ºð ºñ ºò ºó ºô 
              ºõ ºö º÷ ºø ºù ºú ºû ºü ºý ºþ))
(setq jis3b '(»¡ »¢ »£ »¤ »¥ »¦ »§ »¨ »© »ª »« »¬ »­ »® »¯ »° »± »² »³ »´ »µ 
              »¶ »· »¸ »¹ »º »» »¼ »½ »¾ »¿ »À »Á »Â »Ã »Ä »Å »Æ »Ç »È »É »Ê 
              »Ë »Ì »Í »Î »Ï »Ð »Ñ »Ò »Ó »Ô »Õ »Ö »× »Ø »Ù »Ú »Û »Ü »Ý »Þ »ß 
              »à »á »â »ã »ä »å »æ »ç »è »é »ê »ë »ì »í »î »ï »ð »ñ »ò »ó »ô 
              »õ »ö »÷ »ø »ù »ú »û »ü »ý »þ))
(setq jis3c '(¼¡ ¼¢ ¼£ ¼¤ ¼¥ ¼¦ ¼§ ¼¨ ¼© ¼ª ¼« ¼¬ ¼­ ¼® ¼¯ ¼° ¼± ¼² ¼³ ¼´ ¼µ 
              ¼¶ ¼· ¼¸ ¼¹ ¼º ¼» ¼¼ ¼½ ¼¾ ¼¿ ¼À ¼Á ¼Â ¼Ã ¼Ä ¼Å ¼Æ ¼Ç ¼È ¼É ¼Ê 
              ¼Ë ¼Ì ¼Í ¼Î ¼Ï ¼Ð ¼Ñ ¼Ò ¼Ó ¼Ô ¼Õ ¼Ö ¼× ¼Ø ¼Ù ¼Ú ¼Û ¼Ü ¼Ý ¼Þ ¼ß 
              ¼à ¼á ¼â ¼ã ¼ä ¼å ¼æ ¼ç ¼è ¼é ¼ê ¼ë ¼ì ¼í ¼î ¼ï ¼ð ¼ñ ¼ò ¼ó ¼ô 
              ¼õ ¼ö ¼÷ ¼ø ¼ù ¼ú ¼û ¼ü ¼ý ¼þ))
(setq jis3d '(½¡ ½¢ ½£ ½¤ ½¥ ½¦ ½§ ½¨ ½© ½ª ½« ½¬ ½­ ½® ½¯ ½° ½± ½² ½³ ½´ ½µ 
              ½¶ ½· ½¸ ½¹ ½º ½» ½¼ ½½ ½¾ ½¿ ½À ½Á ½Â ½Ã ½Ä ½Å ½Æ ½Ç ½È ½É ½Ê 
              ½Ë ½Ì ½Í ½Î ½Ï ½Ð ½Ñ ½Ò ½Ó ½Ô ½Õ ½Ö ½× ½Ø ½Ù ½Ú ½Û ½Ü ½Ý ½Þ ½ß 
              ½à ½á ½â ½ã ½ä ½å ½æ ½ç ½è ½é ½ê ½ë ½ì ½í ½î ½ï ½ð ½ñ ½ò ½ó ½ô 
              ½õ ½ö ½÷ ½ø ½ù ½ú ½û ½ü ½ý ½þ))
(setq jis3e '(¾¡ ¾¢ ¾£ ¾¤ ¾¥ ¾¦ ¾§ ¾¨ ¾© ¾ª ¾« ¾¬ ¾­ ¾® ¾¯ ¾° ¾± ¾² ¾³ ¾´ ¾µ 
              ¾¶ ¾· ¾¸ ¾¹ ¾º ¾» ¾¼ ¾½ ¾¾ ¾¿ ¾À ¾Á ¾Â ¾Ã ¾Ä ¾Å ¾Æ ¾Ç ¾È ¾É ¾Ê 
              ¾Ë ¾Ì ¾Í ¾Î ¾Ï ¾Ð ¾Ñ ¾Ò ¾Ó ¾Ô ¾Õ ¾Ö ¾× ¾Ø ¾Ù ¾Ú ¾Û ¾Ü ¾Ý ¾Þ ¾ß 
              ¾à ¾á ¾â ¾ã ¾ä ¾å ¾æ ¾ç ¾è ¾é ¾ê ¾ë ¾ì ¾í ¾î ¾ï ¾ð ¾ñ ¾ò ¾ó ¾ô 
              ¾õ ¾ö ¾÷ ¾ø ¾ù ¾ú ¾û ¾ü ¾ý ¾þ))
(setq jis3f '(¿¡ ¿¢ ¿£ ¿¤ ¿¥ ¿¦ ¿§ ¿¨ ¿© ¿ª ¿« ¿¬ ¿­ ¿® ¿¯ ¿° ¿± ¿² ¿³ ¿´ ¿µ 
              ¿¶ ¿· ¿¸ ¿¹ ¿º ¿» ¿¼ ¿½ ¿¾ ¿¿ ¿À ¿Á ¿Â ¿Ã ¿Ä ¿Å ¿Æ ¿Ç ¿È ¿É ¿Ê 
              ¿Ë ¿Ì ¿Í ¿Î ¿Ï ¿Ð ¿Ñ ¿Ò ¿Ó ¿Ô ¿Õ ¿Ö ¿× ¿Ø ¿Ù ¿Ú ¿Û ¿Ü ¿Ý ¿Þ ¿ß 
              ¿à ¿á ¿â ¿ã ¿ä ¿å ¿æ ¿ç ¿è ¿é ¿ê ¿ë ¿ì ¿í ¿î ¿ï ¿ð ¿ñ ¿ò ¿ó ¿ô 
              ¿õ ¿ö ¿÷ ¿ø ¿ù ¿ú ¿û ¿ü ¿ý ¿þ))
(setq jis40 '(À¡ À¢ À£ À¤ À¥ À¦ À§ À¨ À© Àª À« À¬ À­ À® À¯ À° À± À² À³ À´ Àµ 
              À¶ À· À¸ À¹ Àº À» À¼ À½ À¾ À¿ ÀÀ ÀÁ ÀÂ ÀÃ ÀÄ ÀÅ ÀÆ ÀÇ ÀÈ ÀÉ ÀÊ 
              ÀË ÀÌ ÀÍ ÀÎ ÀÏ ÀÐ ÀÑ ÀÒ ÀÓ ÀÔ ÀÕ ÀÖ À× ÀØ ÀÙ ÀÚ ÀÛ ÀÜ ÀÝ ÀÞ Àß 
              Àà Àá Àâ Àã Àä Àå Àæ Àç Àè Àé Àê Àë Àì Àí Àî Àï Àð Àñ Àò Àó Àô 
              Àõ Àö À÷ Àø Àù Àú Àû Àü Àý Àþ))
(setq jis41 '(Á¡ Á¢ Á£ Á¤ Á¥ Á¦ Á§ Á¨ Á© Áª Á« Á¬ Á­ Á® Á¯ Á° Á± Á² Á³ Á´ Áµ 
              Á¶ Á· Á¸ Á¹ Áº Á» Á¼ Á½ Á¾ Á¿ ÁÀ ÁÁ ÁÂ ÁÃ ÁÄ ÁÅ ÁÆ ÁÇ ÁÈ ÁÉ ÁÊ 
              ÁË ÁÌ ÁÍ ÁÎ ÁÏ ÁÐ ÁÑ ÁÒ ÁÓ ÁÔ ÁÕ ÁÖ Á× ÁØ ÁÙ ÁÚ ÁÛ ÁÜ ÁÝ ÁÞ Áß 
              Áà Áá Áâ Áã Áä Áå Áæ Áç Áè Áé Áê Áë Áì Áí Áî Áï Áð Áñ Áò Áó Áô 
              Áõ Áö Á÷ Áø Áù Áú Áû Áü Áý Áþ))
(setq jis42 '(Â¡ Â¢ Â£ Â¤ Â¥ Â¦ Â§ Â¨ Â© Âª Â« Â¬ Â­ Â® Â¯ Â° Â± Â² Â³ Â´ Âµ 
              Â¶ Â· Â¸ Â¹ Âº Â» Â¼ Â½ Â¾ Â¿ ÂÀ ÂÁ ÂÂ ÂÃ ÂÄ ÂÅ ÂÆ ÂÇ ÂÈ ÂÉ ÂÊ 
              ÂË ÂÌ ÂÍ ÂÎ ÂÏ ÂÐ ÂÑ ÂÒ ÂÓ ÂÔ ÂÕ ÂÖ Â× ÂØ ÂÙ ÂÚ ÂÛ ÂÜ ÂÝ ÂÞ Âß 
              Âà Âá Ââ Âã Âä Âå Âæ Âç Âè Âé Âê Âë Âì Âí Âî Âï Âð Âñ Âò Âó Âô 
              Âõ Âö Â÷ Âø Âù Âú Âû Âü Âý Âþ))
(setq jis43 '(Ã¡ Ã¢ Ã£ Ã¤ Ã¥ Ã¦ Ã§ Ã¨ Ã© Ãª Ã« Ã¬ Ã­ Ã® Ã¯ Ã° Ã± Ã² Ã³ Ã´ Ãµ 
              Ã¶ Ã· Ã¸ Ã¹ Ãº Ã» Ã¼ Ã½ Ã¾ Ã¿ ÃÀ ÃÁ ÃÂ ÃÃ ÃÄ ÃÅ ÃÆ ÃÇ ÃÈ ÃÉ ÃÊ 
              ÃË ÃÌ ÃÍ ÃÎ ÃÏ ÃÐ ÃÑ ÃÒ ÃÓ ÃÔ ÃÕ ÃÖ Ã× ÃØ ÃÙ ÃÚ ÃÛ ÃÜ ÃÝ ÃÞ Ãß 
              Ãà Ãá Ãâ Ãã Ãä Ãå Ãæ Ãç Ãè Ãé Ãê Ãë Ãì Ãí Ãî Ãï Ãð Ãñ Ãò Ãó Ãô 
              Ãõ Ãö Ã÷ Ãø Ãù Ãú Ãû Ãü Ãý Ãþ))
(setq jis44 '(Ä¡ Ä¢ Ä£ Ä¤ Ä¥ Ä¦ Ä§ Ä¨ Ä© Äª Ä« Ä¬ Ä­ Ä® Ä¯ Ä° Ä± Ä² Ä³ Ä´ Äµ 
              Ä¶ Ä· Ä¸ Ä¹ Äº Ä» Ä¼ Ä½ Ä¾ Ä¿ ÄÀ ÄÁ ÄÂ ÄÃ ÄÄ ÄÅ ÄÆ ÄÇ ÄÈ ÄÉ ÄÊ 
              ÄË ÄÌ ÄÍ ÄÎ ÄÏ ÄÐ ÄÑ ÄÒ ÄÓ ÄÔ ÄÕ ÄÖ Ä× ÄØ ÄÙ ÄÚ ÄÛ ÄÜ ÄÝ ÄÞ Äß 
              Äà Äá Äâ Äã Ää Äå Äæ Äç Äè Äé Äê Äë Äì Äí Äî Äï Äð Äñ Äò Äó Äô 
              Äõ Äö Ä÷ Äø Äù Äú Äû Äü Äý Äþ))
(setq jis45 '(Å¡ Å¢ Å£ Å¤ Å¥ Å¦ Å§ Å¨ Å© Åª Å« Å¬ Å­ Å® Å¯ Å° Å± Å² Å³ Å´ Åµ 
              Å¶ Å· Å¸ Å¹ Åº Å» Å¼ Å½ Å¾ Å¿ ÅÀ ÅÁ ÅÂ ÅÃ ÅÄ ÅÅ ÅÆ ÅÇ ÅÈ ÅÉ ÅÊ 
              ÅË ÅÌ ÅÍ ÅÎ ÅÏ ÅÐ ÅÑ ÅÒ ÅÓ ÅÔ ÅÕ ÅÖ Å× ÅØ ÅÙ ÅÚ ÅÛ ÅÜ ÅÝ ÅÞ Åß 
              Åà Åá Åâ Åã Åä Åå Åæ Åç Åè Åé Åê Åë Åì Åí Åî Åï Åð Åñ Åò Åó Åô 
              Åõ Åö Å÷ Åø Åù Åú Åû Åü Åý Åþ))
(setq jis46 '(Æ¡ Æ¢ Æ£ Æ¤ Æ¥ Æ¦ Æ§ Æ¨ Æ© Æª Æ« Æ¬ Æ­ Æ® Æ¯ Æ° Æ± Æ² Æ³ Æ´ Æµ 
              Æ¶ Æ· Æ¸ Æ¹ Æº Æ» Æ¼ Æ½ Æ¾ Æ¿ ÆÀ ÆÁ ÆÂ ÆÃ ÆÄ ÆÅ ÆÆ ÆÇ ÆÈ ÆÉ ÆÊ 
              ÆË ÆÌ ÆÍ ÆÎ ÆÏ ÆÐ ÆÑ ÆÒ ÆÓ ÆÔ ÆÕ ÆÖ Æ× ÆØ ÆÙ ÆÚ ÆÛ ÆÜ ÆÝ ÆÞ Æß 
              Æà Æá Æâ Æã Æä Æå Ææ Æç Æè Æé Æê Æë Æì Æí Æî Æï Æð Æñ Æò Æó Æô 
              Æõ Æö Æ÷ Æø Æù Æú Æû Æü Æý Æþ))
(setq jis47 '(Ç¡ Ç¢ Ç£ Ç¤ Ç¥ Ç¦ Ç§ Ç¨ Ç© Çª Ç« Ç¬ Ç­ Ç® Ç¯ Ç° Ç± Ç² Ç³ Ç´ Çµ 
              Ç¶ Ç· Ç¸ Ç¹ Çº Ç» Ç¼ Ç½ Ç¾ Ç¿ ÇÀ ÇÁ ÇÂ ÇÃ ÇÄ ÇÅ ÇÆ ÇÇ ÇÈ ÇÉ ÇÊ 
              ÇË ÇÌ ÇÍ ÇÎ ÇÏ ÇÐ ÇÑ ÇÒ ÇÓ ÇÔ ÇÕ ÇÖ Ç× ÇØ ÇÙ ÇÚ ÇÛ ÇÜ ÇÝ ÇÞ Çß 
              Çà Çá Çâ Çã Çä Çå Çæ Çç Çè Çé Çê Çë Çì Çí Çî Çï Çð Çñ Çò Çó Çô 
              Çõ Çö Ç÷ Çø Çù Çú Çû Çü Çý Çþ))
(setq jis48 '(È¡ È¢ È£ È¤ È¥ È¦ È§ È¨ È© Èª È« È¬ È­ È® È¯ È° È± È² È³ È´ Èµ 
              È¶ È· È¸ È¹ Èº È» È¼ È½ È¾ È¿ ÈÀ ÈÁ ÈÂ ÈÃ ÈÄ ÈÅ ÈÆ ÈÇ ÈÈ ÈÉ ÈÊ 
              ÈË ÈÌ ÈÍ ÈÎ ÈÏ ÈÐ ÈÑ ÈÒ ÈÓ ÈÔ ÈÕ ÈÖ È× ÈØ ÈÙ ÈÚ ÈÛ ÈÜ ÈÝ ÈÞ Èß 
              Èà Èá Èâ Èã Èä Èå Èæ Èç Èè Èé Èê Èë Èì Èí Èî Èï Èð Èñ Èò Èó Èô 
              Èõ Èö È÷ Èø Èù Èú Èû Èü Èý Èþ))
(setq jis49 '(É¡ É¢ É£ É¤ É¥ É¦ É§ É¨ É© Éª É« É¬ É­ É® É¯ É° É± É² É³ É´ Éµ 
              É¶ É· É¸ É¹ Éº É» É¼ É½ É¾ É¿ ÉÀ ÉÁ ÉÂ ÉÃ ÉÄ ÉÅ ÉÆ ÉÇ ÉÈ ÉÉ ÉÊ 
              ÉË ÉÌ ÉÍ ÉÎ ÉÏ ÉÐ ÉÑ ÉÒ ÉÓ ÉÔ ÉÕ ÉÖ É× ÉØ ÉÙ ÉÚ ÉÛ ÉÜ ÉÝ ÉÞ Éß 
              Éà Éá Éâ Éã Éä Éå Éæ Éç Éè Éé Éê Éë Éì Éí Éî Éï Éð Éñ Éò Éó Éô 
              Éõ Éö É÷ Éø Éù Éú Éû Éü Éý Éþ))
(setq jis4a '(Ê¡ Ê¢ Ê£ Ê¤ Ê¥ Ê¦ Ê§ Ê¨ Ê© Êª Ê« Ê¬ Ê­ Ê® Ê¯ Ê° Ê± Ê² Ê³ Ê´ Êµ 
              Ê¶ Ê· Ê¸ Ê¹ Êº Ê» Ê¼ Ê½ Ê¾ Ê¿ ÊÀ ÊÁ ÊÂ ÊÃ ÊÄ ÊÅ ÊÆ ÊÇ ÊÈ ÊÉ ÊÊ 
              ÊË ÊÌ ÊÍ ÊÎ ÊÏ ÊÐ ÊÑ ÊÒ ÊÓ ÊÔ ÊÕ ÊÖ Ê× ÊØ ÊÙ ÊÚ ÊÛ ÊÜ ÊÝ ÊÞ Êß 
              Êà Êá Êâ Êã Êä Êå Êæ Êç Êè Êé Êê Êë Êì Êí Êî Êï Êð Êñ Êò Êó Êô 
              Êõ Êö Ê÷ Êø Êù Êú Êû Êü Êý Êþ))
(setq jis4b '(Ë¡ Ë¢ Ë£ Ë¤ Ë¥ Ë¦ Ë§ Ë¨ Ë© Ëª Ë« Ë¬ Ë­ Ë® Ë¯ Ë° Ë± Ë² Ë³ Ë´ Ëµ 
              Ë¶ Ë· Ë¸ Ë¹ Ëº Ë» Ë¼ Ë½ Ë¾ Ë¿ ËÀ ËÁ ËÂ ËÃ ËÄ ËÅ ËÆ ËÇ ËÈ ËÉ ËÊ 
              ËË ËÌ ËÍ ËÎ ËÏ ËÐ ËÑ ËÒ ËÓ ËÔ ËÕ ËÖ Ë× ËØ ËÙ ËÚ ËÛ ËÜ ËÝ ËÞ Ëß 
              Ëà Ëá Ëâ Ëã Ëä Ëå Ëæ Ëç Ëè Ëé Ëê Ëë Ëì Ëí Ëî Ëï Ëð Ëñ Ëò Ëó Ëô 
              Ëõ Ëö Ë÷ Ëø Ëù Ëú Ëû Ëü Ëý Ëþ))
(setq jis4c '(Ì¡ Ì¢ Ì£ Ì¤ Ì¥ Ì¦ Ì§ Ì¨ Ì© Ìª Ì« Ì¬ Ì­ Ì® Ì¯ Ì° Ì± Ì² Ì³ Ì´ Ìµ 
              Ì¶ Ì· Ì¸ Ì¹ Ìº Ì» Ì¼ Ì½ Ì¾ Ì¿ ÌÀ ÌÁ ÌÂ ÌÃ ÌÄ ÌÅ ÌÆ ÌÇ ÌÈ ÌÉ ÌÊ 
              ÌË ÌÌ ÌÍ ÌÎ ÌÏ ÌÐ ÌÑ ÌÒ ÌÓ ÌÔ ÌÕ ÌÖ Ì× ÌØ ÌÙ ÌÚ ÌÛ ÌÜ ÌÝ ÌÞ Ìß 
              Ìà Ìá Ìâ Ìã Ìä Ìå Ìæ Ìç Ìè Ìé Ìê Ìë Ìì Ìí Ìî Ìï Ìð Ìñ Ìò Ìó Ìô 
              Ìõ Ìö Ì÷ Ìø Ìù Ìú Ìû Ìü Ìý Ìþ))
(setq jis4d '(Í¡ Í¢ Í£ Í¤ Í¥ Í¦ Í§ Í¨ Í© Íª Í« Í¬ Í­ Í® Í¯ Í° Í± Í² Í³ Í´ Íµ 
              Í¶ Í· Í¸ Í¹ Íº Í» Í¼ Í½ Í¾ Í¿ ÍÀ ÍÁ ÍÂ ÍÃ ÍÄ ÍÅ ÍÆ ÍÇ ÍÈ ÍÉ ÍÊ 
              ÍË ÍÌ ÍÍ ÍÎ ÍÏ ÍÐ ÍÑ ÍÒ ÍÓ ÍÔ ÍÕ ÍÖ Í× ÍØ ÍÙ ÍÚ ÍÛ ÍÜ ÍÝ ÍÞ Íß 
              Íà Íá Íâ Íã Íä Íå Íæ Íç Íè Íé Íê Íë Íì Íí Íî Íï Íð Íñ Íò Íó Íô 
              Íõ Íö Í÷ Íø Íù Íú Íû Íü Íý Íþ))
(setq jis4e '(Î¡ Î¢ Î£ Î¤ Î¥ Î¦ Î§ Î¨ Î© Îª Î« Î¬ Î­ Î® Î¯ Î° Î± Î² Î³ Î´ Îµ 
              Î¶ Î· Î¸ Î¹ Îº Î» Î¼ Î½ Î¾ Î¿ ÎÀ ÎÁ ÎÂ ÎÃ ÎÄ ÎÅ ÎÆ ÎÇ ÎÈ ÎÉ ÎÊ 
              ÎË ÎÌ ÎÍ ÎÎ ÎÏ ÎÐ ÎÑ ÎÒ ÎÓ ÎÔ ÎÕ ÎÖ Î× ÎØ ÎÙ ÎÚ ÎÛ ÎÜ ÎÝ ÎÞ Îß 
              Îà Îá Îâ Îã Îä Îå Îæ Îç Îè Îé Îê Îë Îì Îí Îî Îï Îð Îñ Îò Îó Îô 
              Îõ Îö Î÷ Îø Îù Îú Îû Îü Îý Îþ))
(setq jis4f '(Ï¡ Ï¢ Ï£ Ï¤ Ï¥ Ï¦ Ï§ Ï¨ Ï© Ïª Ï« Ï¬ Ï­ Ï® Ï¯ Ï° Ï± Ï² Ï³ Ï´ Ïµ 
              Ï¶ Ï· Ï¸ Ï¹ Ïº Ï» Ï¼ Ï½ Ï¾ Ï¿ ÏÀ ÏÁ ÏÂ ÏÃ ÏÄ ÏÅ ÏÆ ÏÇ ÏÈ ÏÉ ÏÊ 
              ÏË ÏÌ ÏÍ ÏÎ ÏÏ ÏÐ ÏÑ ÏÒ ÏÓ))
(setq jis50 '(
Ð¡ Ð¢ Ð£ Ð¤ Ð¥ Ð¦ Ð§ Ð¨ Ð© Ðª Ð« Ð¬ Ð­ Ð® Ð¯ Ð° Ð± Ð² Ð³ Ð´ Ðµ Ð¶ Ð· Ð¸ Ð¹ Ðº Ð» Ð¼ Ð½ Ð¾ Ð¿ ÐÀ ÐÁ ÐÂ ÐÃ ÐÄ ÐÅ ÐÆ ÐÇ ÐÈ ÐÉ ÐÊ ÐË ÐÌ ÐÍ ÐÎ ÐÏ ÐÐ ÐÑ ÐÒ ÐÓ ÐÔ ÐÕ ÐÖ Ð× ÐØ ÐÙ ÐÚ ÐÛ ÐÜ ÐÝ ÐÞ Ðß Ðà Ðá Ðâ Ðã Ðä Ðå Ðæ Ðç Ðè Ðé Ðê Ðë Ðì Ðí Ðî Ðï Ðð Ðñ Ðò Ðó Ðô Ðõ Ðö Ð÷ Ðø Ðù Ðú Ðû Ðü Ðý Ðþ 
))
(setq jis51 '(
Ñ¡ Ñ¢ Ñ£ Ñ¤ Ñ¥ Ñ¦ Ñ§ Ñ¨ Ñ© Ñª Ñ« Ñ¬ Ñ­ Ñ® Ñ¯ Ñ° Ñ± Ñ² Ñ³ Ñ´ Ñµ Ñ¶ Ñ· Ñ¸ Ñ¹ Ñº Ñ» Ñ¼ Ñ½ Ñ¾ Ñ¿ ÑÀ ÑÁ ÑÂ ÑÃ ÑÄ ÑÅ ÑÆ ÑÇ ÑÈ ÑÉ ÑÊ ÑË ÑÌ ÑÍ ÑÎ ÑÏ ÑÐ ÑÑ ÑÒ ÑÓ ÑÔ ÑÕ ÑÖ Ñ× ÑØ ÑÙ ÑÚ ÑÛ ÑÜ ÑÝ ÑÞ Ñß Ñà Ñá Ñâ Ñã Ñä Ñå Ñæ Ñç Ñè Ñé Ñê Ñë Ñì Ñí Ñî Ñï Ñð Ññ Ñò Ñó Ñô Ñõ Ñö Ñ÷ Ñø Ñù Ñú Ñû Ñü Ñý Ñþ 
))
(setq jis52 '(
Ò¡ Ò¢ Ò£ Ò¤ Ò¥ Ò¦ Ò§ Ò¨ Ò© Òª Ò« Ò¬ Ò­ Ò® Ò¯ Ò° Ò± Ò² Ò³ Ò´ Òµ Ò¶ Ò· Ò¸ Ò¹ Òº Ò» Ò¼ Ò½ Ò¾ Ò¿ ÒÀ ÒÁ ÒÂ ÒÃ ÒÄ ÒÅ ÒÆ ÒÇ ÒÈ ÒÉ ÒÊ ÒË ÒÌ ÒÍ ÒÎ ÒÏ ÒÐ ÒÑ ÒÒ ÒÓ ÒÔ ÒÕ ÒÖ Ò× ÒØ ÒÙ ÒÚ ÒÛ ÒÜ ÒÝ ÒÞ Òß Òà Òá Òâ Òã Òä Òå Òæ Òç Òè Òé Òê Òë Òì Òí Òî Òï Òð Òñ Òò Òó Òô Òõ Òö Ò÷ Òø Òù Òú Òû Òü Òý Òþ 
))
(setq jis53 '(
Ó¡ Ó¢ Ó£ Ó¤ Ó¥ Ó¦ Ó§ Ó¨ Ó© Óª Ó« Ó¬ Ó­ Ó® Ó¯ Ó° Ó± Ó² Ó³ Ó´ Óµ Ó¶ Ó· Ó¸ Ó¹ Óº Ó» Ó¼ Ó½ Ó¾ Ó¿ ÓÀ ÓÁ ÓÂ ÓÃ ÓÄ ÓÅ ÓÆ ÓÇ ÓÈ ÓÉ ÓÊ ÓË ÓÌ ÓÍ ÓÎ ÓÏ ÓÐ ÓÑ ÓÒ ÓÓ ÓÔ ÓÕ ÓÖ Ó× ÓØ ÓÙ ÓÚ ÓÛ ÓÜ ÓÝ ÓÞ Óß Óà Óá Óâ Óã Óä Óå Óæ Óç Óè Óé Óê Óë Óì Óí Óî Óï Óð Óñ Óò Óó Óô Óõ Óö Ó÷ Óø Óù Óú Óû Óü Óý Óþ 
))
(setq jis54 '(
Ô¡ Ô¢ Ô£ Ô¤ Ô¥ Ô¦ Ô§ Ô¨ Ô© Ôª Ô« Ô¬ Ô­ Ô® Ô¯ Ô° Ô± Ô² Ô³ Ô´ Ôµ Ô¶ Ô· Ô¸ Ô¹ Ôº Ô» Ô¼ Ô½ Ô¾ Ô¿ ÔÀ ÔÁ ÔÂ ÔÃ ÔÄ ÔÅ ÔÆ ÔÇ ÔÈ ÔÉ ÔÊ ÔË ÔÌ ÔÍ ÔÎ ÔÏ ÔÐ ÔÑ ÔÒ ÔÓ ÔÔ ÔÕ ÔÖ Ô× ÔØ ÔÙ ÔÚ ÔÛ ÔÜ ÔÝ ÔÞ Ôß Ôà Ôá Ôâ Ôã Ôä Ôå Ôæ Ôç Ôè Ôé Ôê Ôë Ôì Ôí Ôî Ôï Ôð Ôñ Ôò Ôó Ôô Ôõ Ôö Ô÷ Ôø Ôù Ôú Ôû Ôü Ôý Ôþ 
))
(setq jis55 '(
Õ¡ Õ¢ Õ£ Õ¤ Õ¥ Õ¦ Õ§ Õ¨ Õ© Õª Õ« Õ¬ Õ­ Õ® Õ¯ Õ° Õ± Õ² Õ³ Õ´ Õµ Õ¶ Õ· Õ¸ Õ¹ Õº Õ» Õ¼ Õ½ Õ¾ Õ¿ ÕÀ ÕÁ ÕÂ ÕÃ ÕÄ ÕÅ ÕÆ ÕÇ ÕÈ ÕÉ ÕÊ ÕË ÕÌ ÕÍ ÕÎ ÕÏ ÕÐ ÕÑ ÕÒ ÕÓ ÕÔ ÕÕ ÕÖ Õ× ÕØ ÕÙ ÕÚ ÕÛ ÕÜ ÕÝ ÕÞ Õß Õà Õá Õâ Õã Õä Õå Õæ Õç Õè Õé Õê Õë Õì Õí Õî Õï Õð Õñ Õò Õó Õô Õõ Õö Õ÷ Õø Õù Õú Õû Õü Õý Õþ 
))
(setq jis56 '(
Ö¡ Ö¢ Ö£ Ö¤ Ö¥ Ö¦ Ö§ Ö¨ Ö© Öª Ö« Ö¬ Ö­ Ö® Ö¯ Ö° Ö± Ö² Ö³ Ö´ Öµ Ö¶ Ö· Ö¸ Ö¹ Öº Ö» Ö¼ Ö½ Ö¾ Ö¿ ÖÀ ÖÁ ÖÂ ÖÃ ÖÄ ÖÅ ÖÆ ÖÇ ÖÈ ÖÉ ÖÊ ÖË ÖÌ ÖÍ ÖÎ ÖÏ ÖÐ ÖÑ ÖÒ ÖÓ ÖÔ ÖÕ ÖÖ Ö× ÖØ ÖÙ ÖÚ ÖÛ ÖÜ ÖÝ ÖÞ Öß Öà Öá Öâ Öã Öä Öå Öæ Öç Öè Öé Öê Öë Öì Öí Öî Öï Öð Öñ Öò Öó Öô Öõ Öö Ö÷ Öø Öù Öú Öû Öü Öý Öþ 
))
(setq jis57 '(
×¡ ×¢ ×£ ×¤ ×¥ ×¦ ×§ ×¨ ×© ×ª ×« ×¬ ×­ ×® ×¯ ×° ×± ×² ×³ ×´ ×µ ×¶ ×· ×¸ ×¹ ×º ×» ×¼ ×½ ×¾ ×¿ ×À ×Á ×Â ×Ã ×Ä ×Å ×Æ ×Ç ×È ×É ×Ê ×Ë ×Ì ×Í ×Î ×Ï ×Ð ×Ñ ×Ò ×Ó ×Ô ×Õ ×Ö ×× ×Ø ×Ù ×Ú ×Û ×Ü ×Ý ×Þ ×ß ×à ×á ×â ×ã ×ä ×å ×æ ×ç ×è ×é ×ê ×ë ×ì ×í ×î ×ï ×ð ×ñ ×ò ×ó ×ô ×õ ×ö ×÷ ×ø ×ù ×ú ×û ×ü ×ý ×þ 
))
(setq jis58 '(
Ø¡ Ø¢ Ø£ Ø¤ Ø¥ Ø¦ Ø§ Ø¨ Ø© Øª Ø« Ø¬ Ø­ Ø® Ø¯ Ø° Ø± Ø² Ø³ Ø´ Øµ Ø¶ Ø· Ø¸ Ø¹ Øº Ø» Ø¼ Ø½ Ø¾ Ø¿ ØÀ ØÁ ØÂ ØÃ ØÄ ØÅ ØÆ ØÇ ØÈ ØÉ ØÊ ØË ØÌ ØÍ ØÎ ØÏ ØÐ ØÑ ØÒ ØÓ ØÔ ØÕ ØÖ Ø× ØØ ØÙ ØÚ ØÛ ØÜ ØÝ ØÞ Øß Øà Øá Øâ Øã Øä Øå Øæ Øç Øè Øé Øê Øë Øì Øí Øî Øï Øð Øñ Øò Øó Øô Øõ Øö Ø÷ Øø Øù Øú Øû Øü Øý Øþ 
))
(setq jis59 '(
Ù¡ Ù¢ Ù£ Ù¤ Ù¥ Ù¦ Ù§ Ù¨ Ù© Ùª Ù« Ù¬ Ù­ Ù® Ù¯ Ù° Ù± Ù² Ù³ Ù´ Ùµ Ù¶ Ù· Ù¸ Ù¹ Ùº Ù» Ù¼ Ù½ Ù¾ Ù¿ ÙÀ ÙÁ ÙÂ ÙÃ ÙÄ ÙÅ ÙÆ ÙÇ ÙÈ ÙÉ ÙÊ ÙË ÙÌ ÙÍ ÙÎ ÙÏ ÙÐ ÙÑ ÙÒ ÙÓ ÙÔ ÙÕ ÙÖ Ù× ÙØ ÙÙ ÙÚ ÙÛ ÙÜ ÙÝ ÙÞ Ùß Ùà Ùá Ùâ Ùã Ùä Ùå Ùæ Ùç Ùè Ùé Ùê Ùë Ùì Ùí Ùî Ùï Ùð Ùñ Ùò Ùó Ùô Ùõ Ùö Ù÷ Ùø Ùù Ùú Ùû Ùü Ùý Ùþ 
))
(setq jis5a '(
Ú¡ Ú¢ Ú£ Ú¤ Ú¥ Ú¦ Ú§ Ú¨ Ú© Úª Ú« Ú¬ Ú­ Ú® Ú¯ Ú° Ú± Ú² Ú³ Ú´ Úµ Ú¶ Ú· Ú¸ Ú¹ Úº Ú» Ú¼ Ú½ Ú¾ Ú¿ ÚÀ ÚÁ ÚÂ ÚÃ ÚÄ ÚÅ ÚÆ ÚÇ ÚÈ ÚÉ ÚÊ ÚË ÚÌ ÚÍ ÚÎ ÚÏ ÚÐ ÚÑ ÚÒ ÚÓ ÚÔ ÚÕ ÚÖ Ú× ÚØ ÚÙ ÚÚ ÚÛ ÚÜ ÚÝ ÚÞ Úß Úà Úá Úâ Úã Úä Úå Úæ Úç Úè Úé Úê Úë Úì Úí Úî Úï Úð Úñ Úò Úó Úô Úõ Úö Ú÷ Úø Úù Úú Úû Úü Úý Úþ 
))
(setq jis5b '(
Û¡ Û¢ Û£ Û¤ Û¥ Û¦ Û§ Û¨ Û© Ûª Û« Û¬ Û­ Û® Û¯ Û° Û± Û² Û³ Û´ Ûµ Û¶ Û· Û¸ Û¹ Ûº Û» Û¼ Û½ Û¾ Û¿ ÛÀ ÛÁ ÛÂ ÛÃ ÛÄ ÛÅ ÛÆ ÛÇ ÛÈ ÛÉ ÛÊ ÛË ÛÌ ÛÍ ÛÎ ÛÏ ÛÐ ÛÑ ÛÒ ÛÓ ÛÔ ÛÕ ÛÖ Û× ÛØ ÛÙ ÛÚ ÛÛ ÛÜ ÛÝ ÛÞ Ûß Ûà Ûá Ûâ Ûã Ûä Ûå Ûæ Ûç Ûè Ûé Ûê Ûë Ûì Ûí Ûî Ûï Ûð Ûñ Ûò Ûó Ûô Ûõ Ûö Û÷ Ûø Ûù Ûú Ûû Ûü Ûý Ûþ 
))
(setq jis5c '(
Ü¡ Ü¢ Ü£ Ü¤ Ü¥ Ü¦ Ü§ Ü¨ Ü© Üª Ü« Ü¬ Ü­ Ü® Ü¯ Ü° Ü± Ü² Ü³ Ü´ Üµ Ü¶ Ü· Ü¸ Ü¹ Üº Ü» Ü¼ Ü½ Ü¾ Ü¿ ÜÀ ÜÁ ÜÂ ÜÃ ÜÄ ÜÅ ÜÆ ÜÇ ÜÈ ÜÉ ÜÊ ÜË ÜÌ ÜÍ ÜÎ ÜÏ ÜÐ ÜÑ ÜÒ ÜÓ ÜÔ ÜÕ ÜÖ Ü× ÜØ ÜÙ ÜÚ ÜÛ ÜÜ ÜÝ ÜÞ Üß Üà Üá Üâ Üã Üä Üå Üæ Üç Üè Üé Üê Üë Üì Üí Üî Üï Üð Üñ Üò Üó Üô Üõ Üö Ü÷ Üø Üù Üú Üû Üü Üý Üþ 
))
(setq jis5d '(
Ý¡ Ý¢ Ý£ Ý¤ Ý¥ Ý¦ Ý§ Ý¨ Ý© Ýª Ý« Ý¬ Ý­ Ý® Ý¯ Ý° Ý± Ý² Ý³ Ý´ Ýµ Ý¶ Ý· Ý¸ Ý¹ Ýº Ý» Ý¼ Ý½ Ý¾ Ý¿ ÝÀ ÝÁ ÝÂ ÝÃ ÝÄ ÝÅ ÝÆ ÝÇ ÝÈ ÝÉ ÝÊ ÝË ÝÌ ÝÍ ÝÎ ÝÏ ÝÐ ÝÑ ÝÒ ÝÓ ÝÔ ÝÕ ÝÖ Ý× ÝØ ÝÙ ÝÚ ÝÛ ÝÜ ÝÝ ÝÞ Ýß Ýà Ýá Ýâ Ýã Ýä Ýå Ýæ Ýç Ýè Ýé Ýê Ýë Ýì Ýí Ýî Ýï Ýð Ýñ Ýò Ýó Ýô Ýõ Ýö Ý÷ Ýø Ýù Ýú Ýû Ýü Ýý Ýþ 
))
(setq jis5e '(
Þ¡ Þ¢ Þ£ Þ¤ Þ¥ Þ¦ Þ§ Þ¨ Þ© Þª Þ« Þ¬ Þ­ Þ® Þ¯ Þ° Þ± Þ² Þ³ Þ´ Þµ Þ¶ Þ· Þ¸ Þ¹ Þº Þ» Þ¼ Þ½ Þ¾ Þ¿ ÞÀ ÞÁ ÞÂ ÞÃ ÞÄ ÞÅ ÞÆ ÞÇ ÞÈ ÞÉ ÞÊ ÞË ÞÌ ÞÍ ÞÎ ÞÏ ÞÐ ÞÑ ÞÒ ÞÓ ÞÔ ÞÕ ÞÖ Þ× ÞØ ÞÙ ÞÚ ÞÛ ÞÜ ÞÝ ÞÞ Þß Þà Þá Þâ Þã Þä Þå Þæ Þç Þè Þé Þê Þë Þì Þí Þî Þï Þð Þñ Þò Þó Þô Þõ Þö Þ÷ Þø Þù Þú Þû Þü Þý Þþ 
))
(setq jis5f '(
ß¡ ß¢ ß£ ß¤ ß¥ ß¦ ß§ ß¨ ß© ßª ß« ß¬ ß­ ß® ß¯ ß° ß± ß² ß³ ß´ ßµ ß¶ ß· ß¸ ß¹ ßº ß» ß¼ ß½ ß¾ ß¿ ßÀ ßÁ ßÂ ßÃ ßÄ ßÅ ßÆ ßÇ ßÈ ßÉ ßÊ ßË ßÌ ßÍ ßÎ ßÏ ßÐ ßÑ ßÒ ßÓ ßÔ ßÕ ßÖ ß× ßØ ßÙ ßÚ ßÛ ßÜ ßÝ ßÞ ßß ßà ßá ßâ ßã ßä ßå ßæ ßç ßè ßé ßê ßë ßì ßí ßî ßï ßð ßñ ßò ßó ßô ßõ ßö ß÷ ßø ßù ßú ßû ßü ßý ßþ 
))
(setq jis60 '(
à¡ à¢ à£ à¤ à¥ à¦ à§ à¨ à© àª à« à¬ à­ à® à¯ à° à± à² à³ à´ àµ à¶ à· à¸ à¹ àº à» à¼ à½ à¾ à¿ àÀ àÁ àÂ àÃ àÄ àÅ àÆ àÇ àÈ àÉ àÊ àË àÌ àÍ àÎ àÏ àÐ àÑ àÒ àÓ àÔ àÕ àÖ à× àØ àÙ àÚ àÛ àÜ àÝ àÞ àß àà àá àâ àã àä àå àæ àç àè àé àê àë àì àí àî àï àð àñ àò àó àô àõ àö à÷ àø àù àú àû àü àý àþ 
))
(setq jis61 '(
á¡ á¢ á£ á¤ á¥ á¦ á§ á¨ á© áª á« á¬ á­ á® á¯ á° á± á² á³ á´ áµ á¶ á· á¸ á¹ áº á» á¼ á½ á¾ á¿ áÀ áÁ áÂ áÃ áÄ áÅ áÆ áÇ áÈ áÉ áÊ áË áÌ áÍ áÎ áÏ áÐ áÑ áÒ áÓ áÔ áÕ áÖ á× áØ áÙ áÚ áÛ áÜ áÝ áÞ áß áà áá áâ áã áä áå áæ áç áè áé áê áë áì áí áî áï áð áñ áò áó áô áõ áö á÷ áø áù áú áû áü áý áþ 
))
(setq jis62 '(
â¡ â¢ â£ â¤ â¥ â¦ â§ â¨ â© âª â« â¬ â­ â® â¯ â° â± â² â³ â´ âµ â¶ â· â¸ â¹ âº â» â¼ â½ â¾ â¿ âÀ âÁ âÂ âÃ âÄ âÅ âÆ âÇ âÈ âÉ âÊ âË âÌ âÍ âÎ âÏ âÐ âÑ âÒ âÓ âÔ âÕ âÖ â× âØ âÙ âÚ âÛ âÜ âÝ âÞ âß âà âá ââ âã âä âå âæ âç âè âé âê âë âì âí âî âï âð âñ âò âó âô âõ âö â÷ âø âù âú âû âü âý âþ 
))
(setq jis63 '(
ã¡ ã¢ ã£ ã¤ ã¥ ã¦ ã§ ã¨ ã© ãª ã« ã¬ ã­ ã® ã¯ ã° ã± ã² ã³ ã´ ãµ ã¶ ã· ã¸ ã¹ ãº ã» ã¼ ã½ ã¾ ã¿ ãÀ ãÁ ãÂ ãÃ ãÄ ãÅ ãÆ ãÇ ãÈ ãÉ ãÊ ãË ãÌ ãÍ ãÎ ãÏ ãÐ ãÑ ãÒ ãÓ ãÔ ãÕ ãÖ ã× ãØ ãÙ ãÚ ãÛ ãÜ ãÝ ãÞ ãß ãà ãá ãâ ãã ãä ãå ãæ ãç ãè ãé ãê ãë ãì ãí ãî ãï ãð ãñ ãò ãó ãô ãõ ãö ã÷ ãø ãù ãú ãû ãü ãý ãþ 
))
(setq jis64 '(
ä¡ ä¢ ä£ ä¤ ä¥ ä¦ ä§ ä¨ ä© äª ä« ä¬ ä­ ä® ä¯ ä° ä± ä² ä³ ä´ äµ ä¶ ä· ä¸ ä¹ äº ä» ä¼ ä½ ä¾ ä¿ äÀ äÁ äÂ äÃ äÄ äÅ äÆ äÇ äÈ äÉ äÊ äË äÌ äÍ äÎ äÏ äÐ äÑ äÒ äÓ äÔ äÕ äÖ ä× äØ äÙ äÚ äÛ äÜ äÝ äÞ äß äà äá äâ äã ää äå äæ äç äè äé äê äë äì äí äî äï äð äñ äò äó äô äõ äö ä÷ äø äù äú äû äü äý äþ 
))
(setq jis65 '(
å¡ å¢ å£ å¤ å¥ å¦ å§ å¨ å© åª å« å¬ å­ å® å¯ å° å± å² å³ å´ åµ å¶ å· å¸ å¹ åº å» å¼ å½ å¾ å¿ åÀ åÁ åÂ åÃ åÄ åÅ åÆ åÇ åÈ åÉ åÊ åË åÌ åÍ åÎ åÏ åÐ åÑ åÒ åÓ åÔ åÕ åÖ å× åØ åÙ åÚ åÛ åÜ åÝ åÞ åß åà åá åâ åã åä åå åæ åç åè åé åê åë åì åí åî åï åð åñ åò åó åô åõ åö å÷ åø åù åú åû åü åý åþ 
))
(setq jis66 '(
æ¡ æ¢ æ£ æ¤ æ¥ æ¦ æ§ æ¨ æ© æª æ« æ¬ æ­ æ® æ¯ æ° æ± æ² æ³ æ´ æµ æ¶ æ· æ¸ æ¹ æº æ» æ¼ æ½ æ¾ æ¿ æÀ æÁ æÂ æÃ æÄ æÅ æÆ æÇ æÈ æÉ æÊ æË æÌ æÍ æÎ æÏ æÐ æÑ æÒ æÓ æÔ æÕ æÖ æ× æØ æÙ æÚ æÛ æÜ æÝ æÞ æß æà æá æâ æã æä æå ææ æç æè æé æê æë æì æí æî æï æð æñ æò æó æô æõ æö æ÷ æø æù æú æû æü æý æþ 
))
(setq jis67 '(
ç¡ ç¢ ç£ ç¤ ç¥ ç¦ ç§ ç¨ ç© çª ç« ç¬ ç­ ç® ç¯ ç° ç± ç² ç³ ç´ çµ ç¶ ç· ç¸ ç¹ çº ç» ç¼ ç½ ç¾ ç¿ çÀ çÁ çÂ çÃ çÄ çÅ çÆ çÇ çÈ çÉ çÊ çË çÌ çÍ çÎ çÏ çÐ çÑ çÒ çÓ çÔ çÕ çÖ ç× çØ çÙ çÚ çÛ çÜ çÝ çÞ çß çà çá çâ çã çä çå çæ çç çè çé çê çë çì çí çî çï çð çñ çò çó çô çõ çö ç÷ çø çù çú çû çü çý çþ 
))
(setq jis68 '(
è¡ è¢ è£ è¤ è¥ è¦ è§ è¨ è© èª è« è¬ è­ è® è¯ è° è± è² è³ è´ èµ è¶ è· è¸ è¹ èº è» è¼ è½ è¾ è¿ èÀ èÁ èÂ èÃ èÄ èÅ èÆ èÇ èÈ èÉ èÊ èË èÌ èÍ èÎ èÏ èÐ èÑ èÒ èÓ èÔ èÕ èÖ è× èØ èÙ èÚ èÛ èÜ èÝ èÞ èß èà èá èâ èã èä èå èæ èç èè èé èê èë èì èí èî èï èð èñ èò èó èô èõ èö è÷ èø èù èú èû èü èý èþ 
))
(setq jis69 '(
é¡ é¢ é£ é¤ é¥ é¦ é§ é¨ é© éª é« é¬ é­ é® é¯ é° é± é² é³ é´ éµ é¶ é· é¸ é¹ éº é» é¼ é½ é¾ é¿ éÀ éÁ éÂ éÃ éÄ éÅ éÆ éÇ éÈ éÉ éÊ éË éÌ éÍ éÎ éÏ éÐ éÑ éÒ éÓ éÔ éÕ éÖ é× éØ éÙ éÚ éÛ éÜ éÝ éÞ éß éà éá éâ éã éä éå éæ éç éè éé éê éë éì éí éî éï éð éñ éò éó éô éõ éö é÷ éø éù éú éû éü éý éþ 
))
(setq jis6a '(
ê¡ ê¢ ê£ ê¤ ê¥ ê¦ ê§ ê¨ ê© êª ê« ê¬ ê­ ê® ê¯ ê° ê± ê² ê³ ê´ êµ ê¶ ê· ê¸ ê¹ êº ê» ê¼ ê½ ê¾ ê¿ êÀ êÁ êÂ êÃ êÄ êÅ êÆ êÇ êÈ êÉ êÊ êË êÌ êÍ êÎ êÏ êÐ êÑ êÒ êÓ êÔ êÕ êÖ ê× êØ êÙ êÚ êÛ êÜ êÝ êÞ êß êà êá êâ êã êä êå êæ êç êè êé êê êë êì êí êî êï êð êñ êò êó êô êõ êö ê÷ êø êù êú êû êü êý êþ 
))
(setq jis6b '(
ë¡ ë¢ ë£ ë¤ ë¥ ë¦ ë§ ë¨ ë© ëª ë« ë¬ ë­ ë® ë¯ ë° ë± ë² ë³ ë´ ëµ ë¶ ë· ë¸ ë¹ ëº ë» ë¼ ë½ ë¾ ë¿ ëÀ ëÁ ëÂ ëÃ ëÄ ëÅ ëÆ ëÇ ëÈ ëÉ ëÊ ëË ëÌ ëÍ ëÎ ëÏ ëÐ ëÑ ëÒ ëÓ ëÔ ëÕ ëÖ ë× ëØ ëÙ ëÚ ëÛ ëÜ ëÝ ëÞ ëß ëà ëá ëâ ëã ëä ëå ëæ ëç ëè ëé ëê ëë ëì ëí ëî ëï ëð ëñ ëò ëó ëô ëõ ëö ë÷ ëø ëù ëú ëû ëü ëý ëþ 
))
(setq jis6c '(
ì¡ ì¢ ì£ ì¤ ì¥ ì¦ ì§ ì¨ ì© ìª ì« ì¬ ì­ ì® ì¯ ì° ì± ì² ì³ ì´ ìµ ì¶ ì· ì¸ ì¹ ìº ì» ì¼ ì½ ì¾ ì¿ ìÀ ìÁ ìÂ ìÃ ìÄ ìÅ ìÆ ìÇ ìÈ ìÉ ìÊ ìË ìÌ ìÍ ìÎ ìÏ ìÐ ìÑ ìÒ ìÓ ìÔ ìÕ ìÖ ì× ìØ ìÙ ìÚ ìÛ ìÜ ìÝ ìÞ ìß ìà ìá ìâ ìã ìä ìå ìæ ìç ìè ìé ìê ìë ìì ìí ìî ìï ìð ìñ ìò ìó ìô ìõ ìö ì÷ ìø ìù ìú ìû ìü ìý ìþ 
))
(setq jis6d '(
í¡ í¢ í£ í¤ í¥ í¦ í§ í¨ í© íª í« í¬ í­ í® í¯ í° í± í² í³ í´ íµ í¶ í· í¸ í¹ íº í» í¼ í½ í¾ í¿ íÀ íÁ íÂ íÃ íÄ íÅ íÆ íÇ íÈ íÉ íÊ íË íÌ íÍ íÎ íÏ íÐ íÑ íÒ íÓ íÔ íÕ íÖ í× íØ íÙ íÚ íÛ íÜ íÝ íÞ íß íà íá íâ íã íä íå íæ íç íè íé íê íë íì íí íî íï íð íñ íò íó íô íõ íö í÷ íø íù íú íû íü íý íþ 
))
(setq jis6e '(
î¡ î¢ î£ î¤ î¥ î¦ î§ î¨ î© îª î« î¬ î­ î® î¯ î° î± î² î³ î´ îµ î¶ î· î¸ î¹ îº î» î¼ î½ î¾ î¿ îÀ îÁ îÂ îÃ îÄ îÅ îÆ îÇ îÈ îÉ îÊ îË îÌ îÍ îÎ îÏ îÐ îÑ îÒ îÓ îÔ îÕ îÖ î× îØ îÙ îÚ îÛ îÜ îÝ îÞ îß îà îá îâ îã îä îå îæ îç îè îé îê îë îì îí îî îï îð îñ îò îó îô îõ îö î÷ îø îù îú îû îü îý îþ 
))
(setq jis6f '(
ï¡ ï¢ ï£ ï¤ ï¥ ï¦ ï§ ï¨ ï© ïª ï« ï¬ ï­ ï® ï¯ ï° ï± ï² ï³ ï´ ïµ ï¶ ï· ï¸ ï¹ ïº ï» ï¼ ï½ ï¾ ï¿ ïÀ ïÁ ïÂ ïÃ ïÄ ïÅ ïÆ ïÇ ïÈ ïÉ ïÊ ïË ïÌ ïÍ ïÎ ïÏ ïÐ ïÑ ïÒ ïÓ ïÔ ïÕ ïÖ ï× ïØ ïÙ ïÚ ïÛ ïÜ ïÝ ïÞ ïß ïà ïá ïâ ïã ïä ïå ïæ ïç ïè ïé ïê ïë ïì ïí ïî ïï ïð ïñ ïò ïó ïô ïõ ïö ï÷ ïø ïù ïú ïû ïü ïý ïþ 
))
(setq jis70 '(
ð¡ ð¢ ð£ ð¤ ð¥ ð¦ ð§ ð¨ ð© ðª ð« ð¬ ð­ ð® ð¯ ð° ð± ð² ð³ ð´ ðµ ð¶ ð· ð¸ ð¹ ðº ð» ð¼ ð½ ð¾ ð¿ ðÀ ðÁ ðÂ ðÃ ðÄ ðÅ ðÆ ðÇ ðÈ ðÉ ðÊ ðË ðÌ ðÍ ðÎ ðÏ ðÐ ðÑ ðÒ ðÓ ðÔ ðÕ ðÖ ð× ðØ ðÙ ðÚ ðÛ ðÜ ðÝ ðÞ ðß ðà ðá ðâ ðã ðä ðå ðæ ðç ðè ðé ðê ðë ðì ðí ðî ðï ðð ðñ ðò ðó ðô ðõ ðö ð÷ ðø ðù ðú ðû ðü ðý ðþ 
))
(setq jis71 '(
ñ¡ ñ¢ ñ£ ñ¤ ñ¥ ñ¦ ñ§ ñ¨ ñ© ñª ñ« ñ¬ ñ­ ñ® ñ¯ ñ° ñ± ñ² ñ³ ñ´ ñµ ñ¶ ñ· ñ¸ ñ¹ ñº ñ» ñ¼ ñ½ ñ¾ ñ¿ ñÀ ñÁ ñÂ ñÃ ñÄ ñÅ ñÆ ñÇ ñÈ ñÉ ñÊ ñË ñÌ ñÍ ñÎ ñÏ ñÐ ñÑ ñÒ ñÓ ñÔ ñÕ ñÖ ñ× ñØ ñÙ ñÚ ñÛ ñÜ ñÝ ñÞ ñß ñà ñá ñâ ñã ñä ñå ñæ ñç ñè ñé ñê ñë ñì ñí ñî ñï ñð ññ ñò ñó ñô ñõ ñö ñ÷ ñø ñù ñú ñû ñü ñý ñþ 
))
(setq jis72 '(
ò¡ ò¢ ò£ ò¤ ò¥ ò¦ ò§ ò¨ ò© òª ò« ò¬ ò­ ò® ò¯ ò° ò± ò² ò³ ò´ òµ ò¶ ò· ò¸ ò¹ òº ò» ò¼ ò½ ò¾ ò¿ òÀ òÁ òÂ òÃ òÄ òÅ òÆ òÇ òÈ òÉ òÊ òË òÌ òÍ òÎ òÏ òÐ òÑ òÒ òÓ òÔ òÕ òÖ ò× òØ òÙ òÚ òÛ òÜ òÝ òÞ òß òà òá òâ òã òä òå òæ òç òè òé òê òë òì òí òî òï òð òñ òò òó òô òõ òö ò÷ òø òù òú òû òü òý òþ 
))
(setq jis73 '(
ó¡ ó¢ ó£ ó¤ ó¥ ó¦ ó§ ó¨ ó© óª ó« ó¬ ó­ ó® ó¯ ó° ó± ó² ó³ ó´ óµ ó¶ ó· ó¸ ó¹ óº ó» ó¼ ó½ ó¾ ó¿ óÀ óÁ óÂ óÃ óÄ óÅ óÆ óÇ óÈ óÉ óÊ óË óÌ óÍ óÎ óÏ óÐ óÑ óÒ óÓ óÔ óÕ óÖ ó× óØ óÙ óÚ óÛ óÜ óÝ óÞ óß óà óá óâ óã óä óå óæ óç óè óé óê óë óì óí óî óï óð óñ óò óó óô óõ óö ó÷ óø óù óú óû óü óý óþ 
))
(setq jis74 '(
ô¡ ô¢ ô£ ô¤ ô¥ ô¦
; jis7425 jis7426
;           ^  ^
))
(setq allsym (append jis21 jis22 jis23 jis24 jis25 jis26 jis27))
(setq alljis1 (append jis30 jis31 jis32 jis33 jis34 jis35 jis36 jis37 jis38 jis39 jis3a jis3b jis3c jis3d jis3e jis3f jis40 jis41 jis42 jis43 jis44 jis45 jis46 jis47 jis48 jis49 jis4a jis4b jis4c jis4d jis4e jis4f))

(setq alljis2 (append jis50 jis51 jis52 jis53 jis54 jis55 jis56 jis57 jis58 jis59 jis5a jis5b jis5c jis5d jis5e jis5f jis60 jis61 jis62 jis63 jis64 jis65 jis66 jis67 jis68 jis69 jis6a jis6b jis6c jis6d jis6e jis6f jis70 jis71 jis72 jis73 jis74))

(setq alljis (append alljis1 alljis2))
(setq allku '(     "21" "22" "23" "24" "25" "26" "27" 
	      "30" "31" "32" "33" "34" "35" "36" "37"
	      "38" "39" "3A" "3B" "3C" "3D" "3E" "3F"
	      "40" "41" "42" "43" "44" "45" "46" "47"
	      "48" "49" "4A" "4B" "4C" "4D" "4E" "4F"
	      "50" "51" "52" "53" "54" "55" "56" "57"
	      "58" "59" "5A" "5B" "5C" "5D" "5E" "5F"
	      "60" "61" "62" "63" "64" "65" "66" "67"
	      "68" "69" "6A" "6B" "6C" "6D" "6E" "6F"
	      "70" "71" "72" "73" "74"))
