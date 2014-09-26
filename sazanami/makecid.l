; Copyright (c) 1990-2003
;	Wada Laboratory, the University of Tokyo. All rights reserved.
; Copyright (c) 2003-2006
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

(load "load.l")

(setq allkanji 
'(
cid7633 cid7634 cid7635 cid7636 cid7637 cid7638 cid7639 cid7640
cid7641 cid7642 cid7643 cid7644 cid7645 cid7646 cid7647 cid7648
cid7649 cid7650 cid7651 cid7652 cid7653 cid7654 cid7655 cid7656
cid7657 cid7658 cid7659 cid7660 cid7661 cid7662 cid7663 cid7664
cid7665 cid7666 cid7667 cid7668 cid7669 cid7670 cid7671 cid7672
;cid7673 
cid7674 cid7675 cid7676 cid7677 cid7678 cid7679 cid7680
cid7681 cid7682 cid7683 cid7684 cid7685 cid7686 cid7687 cid7688
cid7689 cid7690 cid7691 cid7692 cid7693 cid7694 cid7695 cid7696
cid7697 cid7698 cid7699 cid7700 cid7701 cid7702 cid7703 cid7704
cid7705 cid7706 cid7707 cid7708 cid7709 cid7710 cid7711 cid7712
cid7713 cid7714 cid7715 cid7716 cid7717 cid7718 cid7719 cid7720
cid7721 cid7722 cid7723 cid7724 cid7725 cid7726 cid7727 cid7728
cid7729 cid7730 cid7731 cid7732 cid7733 cid7734 cid7735 cid7736
cid7737 cid7738 cid7739 cid7740 cid7741 cid7742 cid7743 cid7744
cid7745 cid7746 cid7747 cid7748 cid7749 cid7750 cid7751 cid7752
cid7753 cid7754 ;cid7755 
cid7756 cid7757 cid7758 cid7759 cid7760
cid7761 cid7762 cid7763 cid7764 cid7765 cid7766 cid7767 cid7768
cid7769 cid7770 cid7771 cid7772 cid7773 cid7774 cid7775 cid7776
cid7777 cid7778 cid7779 cid7780 cid7781 cid7782 cid7783 cid7784
cid7785 cid7786 cid7787 cid7788 cid7789 cid7790 cid7791 cid7792
cid7793 cid7794 cid7795 cid7796 cid7797 cid7798 cid7799 cid7800
cid7801 cid7802 cid7803 cid7804 cid7805 cid7806 cid7807 cid7808
cid7809 cid7810 cid7811 cid7812 cid7813 cid7814 cid7815 cid7816
cid7817 cid7818 cid7819 cid7820 cid7821 cid7822 cid7823 cid7824
cid7825 cid7826 cid7827 cid7828 cid7829 cid7830 cid7831 cid7832
cid7833 cid7834 cid7835 cid7836 cid7837 cid7838 cid7839 cid7840
cid7841 cid7842 cid7843 cid7844 cid7845 cid7846 cid7847 cid7848
cid7849 cid7850 cid7851 cid7852 cid7853 cid7854 cid7855 cid7856
cid7857 cid7858 cid7859 cid7860 cid7861 cid7862 cid7863 cid7864
cid7865 cid7866 cid7867 cid7868 cid7869 cid7870 cid7871 cid7872
cid7873 cid7874 cid7875 cid7876 cid7877 cid7878 cid7879 ; cid7880
cid7881 cid7882 cid7883 cid7884 cid7885 cid7886 
cid7961 cid7962 cid7963 cid7964 cid7965 cid7966 cid7967 cid7968
cid7969 cid7970 cid7971 cid7972 cid7973 cid7974 cid7975 cid7976
cid7977 cid7978 cid7979 cid7980 cid7981 cid7982 cid7983 cid7984
cid7985 cid7986 cid7987 cid7988 cid7989 cid7990 cid7991 cid7992
cid7993 cid7994 cid7995 cid7996 cid7997 cid7998 cid7999 cid8000
cid8001 cid8002 cid8003 cid8004 
cid8422 cid8442))

(setq minchowidth 11.0)
(out-to-sfd-all allkanji 'mincho "Sznm-M-CIDK.sfd" "Sazanami Mincho Medium"
		:generates-cidfont t :remove-overlap nil)

(setq gothicwidth 13.0)
(out-to-sfd-all allkanji 'gothic "Sznm-G-CIDK.sfd" "Sazanami Gothic Medium"
		:generates-cidfont t :remove-overlap nil)

(quit)
