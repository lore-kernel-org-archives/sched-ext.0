Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F441D63F
	for <sched-ext@lists.linux.dev>; Fri, 14 Aug 2026 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693885; cv=none; b=dW1i5Mg3VM5zHm/AoxLw/bQAYEmNN3tiTpOAObvjcO3q9ZHRoAJahyc4k+MiQkWd/mn+NEh3YbFjgwV7NRYf/DmAA3Ahy8Y1bNELHqrhmW/4ct7PRUWEHFV24W0wcgi0sLuxEgvEdbYwSAz0Lt/vh/iRDyQSBgOzoGkM1MElgLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693885; c=relaxed/simple;
	bh=4i2fY5nv4LWBRynnBWy66tM+604aHi4WdBxv+wgPslw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvHKFH74d0O7fSt1cSTG3z66hyCawi488EZDntdrtuEYRwG45CrFWJRIiVjl98E03G0B5V4MLOyjW3MyyBn57MYIVpl1JOL5yQWkrUIl+g7QKEYG3Z68YsI1yzd5fYeslzXI5C+RICsbHkSOZ59hzA1ALDKndvbV31uHqbtig/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyUrYb/h; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyUrYb/h"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caced6038eso8299035ad.0
        for <sched-ext@lists.linux.dev>; Fri, 14 Aug 2026 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786693876; x=1787298676; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ic+zxcFnUgGphC+WM5P08jxKZUHNK9ABeGTpRSb9nWQ=;
        b=XyUrYb/h/kfV1k3MWLCAt2duxlK718BbwZpSo91AZ5YKSgtfM5g3gYCAkuIBD6fAeg
         5Q0et35dNMMKuaSTs0AyV0FJRO5Pr25paO7Aajo/6hUOOhlLs6lUD/o/Galhcwm+NbU/
         FctjGi5v6QqZHzTofMh4p2L2zYo0MTqkSH69dFuDiGay1qyfYwmrOxVs9JS/3ExrTIMU
         WHtYCZBsudqD6dHW5Q+4AQEyZIdZZHYzquLDBsz90TlculDezvAQhlhAzJulpJXfOzRt
         XIV4fMx3STTbV3Ck8xBcjhyG/up8vLgXsofN05tpesIG8Db9KIxcseifiguUgJWgkvSm
         l3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786693876; x=1787298676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ic+zxcFnUgGphC+WM5P08jxKZUHNK9ABeGTpRSb9nWQ=;
        b=T6O6B2fRoXgOVjv490UPunoirncERAvQnzkJTDPs7YlrMkpxcKssBF7+PXXKSXXOu2
         bs4Zdd6DcMEA5ftxs/mv2NzlyIACa2d3ZPhVXITcf/Mz22ZtGxFJ/a3DDQ3diWDdkkMI
         0ur/LHvT1qqbSSBL/7etXWvMQyaZW7uVD93tlG1Xdxq7FomZGFMIaIVwxdmpMU/67alr
         9n8TFdgwOTH2I6AzqZmElswyV3kzmBCMbj303Sw8KBeNiOSD3RcbyFrjz2gJF/R+vMBn
         H8n3y2Oj8PoOyH69zvxT+gdvGbpYHGctTW1ZR07iL0OzIXYVyjtUIXgJGQeXkPDlj/ZZ
         qBWA==
X-Forwarded-Encrypted: i=1; AHgh+RrnzPk+2J32OQ4o0W9SJ/EzVN1vqjnDPlKuyPEi7xZPGBd+sRYPfrqV3+/v0mUSh796deHBlSM1SCw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3RViWpzIvHVoR3wVNVkjkIxgTcaBYl3BwGnxoLCbuL9f/ipJC
	MILow7WpexeETAn44Xum3bSnQTeVkGgh55XLoi/WJ9xl0k3hjUM3pUkJ
X-Gm-Gg: AR+sD11dn8fwyYQ4xtsqF4IBiqJK2WX/fXdbKKuIHvrpYCmfdvQ7beir4G8pFMTPocI
	ac7xihchY/yiwRF7BU23ZXNvjQaTRk5tvtXqUJ2XN2br29q9D2yxbQMnrL+vEf/heaS+fwY5Xxe
	kamSwZUaDdLQXLfuqxeq+IPoA8VdPIY48q0Y9B7iFkPrO2KX9foq/3mDikTg7YoT4blbp3Iz9f3
	DB67gtdvhpYhk906CI6oHPAmD7xieMw0wVXmMuCzINv2S5rUiAHNRQU6Vjmvpl/7UmNM4IoZHFe
	Xn+rpNjpEv2hYrso1uAytkpRwGG4lvv5OYzIGlW6Y+l8bvIODXashgdGsKW7ZagG8GoL0wOtAFT
	i+mXp9psNTekjK7bG3VnmB4Sp3ShAoJMJVu/Z9aTn2KAdvxZcNlR+016jXCmOlEhZknTH582hUP
	coY3bFG55pYeu4ro+uTh75/Sqw28c38sVtHLS5K/+pqCT+KctgdUDKsUs=
X-Received: by 2002:a17:903:1a0d:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d37f7b7ca7mr136997765ad.13.1786693876317;
        Fri, 14 Aug 2026 00:51:16 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:40::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df2504sm1278521eec.17.2026.08.14.00.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:51:15 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Vernet <void@manifault.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Viktor Malik <vmalik@redhat.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Mykola Lysenko <mykolal@meta.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ziyang Men <ziyang.meme@gmail.com>,
	kernel-team@meta.com,
	linux-kselftest@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-input@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] selftests/hid: build the BPF program via the shared lib.bpf.mk
Date: Fri, 14 Aug 2026 00:50:53 -0700
Message-ID: <20260814075054.507089-4-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814075054.507089-1-ziyang.meme@gmail.com>
References: <20260814075054.507089-1-ziyang.meme@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hid carries its own ~150 lines of libbpf + bpftool + vmlinux.h +
BPF-object + skeleton build machinery, copied from selftests/bpf.
Replace it with an include of the shared
tools/testing/selftests/lib.bpf.mk, so that the previous ~150 lines of
BPF build configuration can now be achieved in only ~10 lines.

The generated hid.skel.h public API is same before and after, hid_bpf
and hidraw are built and linked the same way.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Mykola Lysenko <mykolal@meta.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ziyang Men <ziyang.meme@gmail.com>
---
 tools/testing/selftests/hid/.gitignore |   1 +
 tools/testing/selftests/hid/Makefile   | 180 +++----------------------
 2 files changed, 20 insertions(+), 161 deletions(-)

diff --git a/tools/testing/selftests/hid/.gitignore b/tools/testing/selftests/hid/.gitignore
index 933f483815b2..69943301dc1d 100644
--- a/tools/testing/selftests/hid/.gitignore
+++ b/tools/testing/selftests/hid/.gitignore
@@ -1,5 +1,6 @@
 bpftool
 *.skel.h
+*.bpf.d
 /host-tools
 /tools
 hid_bpf
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 2f423de83147..1d7c64ec992c 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -58,172 +58,31 @@ override define CLEAN
 	$(Q)$(RM) -r $(EXTRA_CLEAN)
 endef
 
+# progs/hid.c is built into a skeleton by ../lib.bpf.mk.  hid keeps the legacy
+# progs/<name>.c layout, hence BPF_PROG_EXT.  BPF_EXTRA_HDRS is deferred: it
+# uses $(BPFDIR), which lib.bpf.mk defines.
+BPF_SRCS       := $(wildcard progs/*.c)
+BPF_PROG_EXT   := .c
+BPF_EXTRA_HDRS  = $(wildcard progs/*.h) $(wildcard $(BPFDIR)/hid_bpf_*.h) \
+		  $(wildcard $(BPFDIR)/*.bpf.h)
+# hid.c predates the shared -Wall and has a few unused locals.
+BPF_EXTRA_CFLAGS := -Wno-unused-variable
+
 include ../lib.mk
+include ../lib.bpf.mk
 
-TOOLSDIR := $(top_srcdir)/tools
-LIBDIR := $(TOOLSDIR)/lib
-BPFDIR := $(LIBDIR)/bpf
-TOOLSINCDIR := $(TOOLSDIR)/include
-BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
-SCRATCH_DIR := $(OUTPUT)/tools
-BUILD_DIR := $(SCRATCH_DIR)/build
-INCLUDE_DIR := $(SCRATCH_DIR)/include
-BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
-ifneq ($(CROSS_COMPILE),)
-HOST_BUILD_DIR		:= $(BUILD_DIR)/host
-HOST_SCRATCH_DIR	:= $(OUTPUT)/host-tools
-HOST_INCLUDE_DIR	:= $(HOST_SCRATCH_DIR)/include
-else
-HOST_BUILD_DIR		:= $(BUILD_DIR)
-HOST_SCRATCH_DIR	:= $(SCRATCH_DIR)
-HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
-endif
-HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
-RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
-
-VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)				\
-		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)	\
-		     ../../../../vmlinux				\
-		     /sys/kernel/btf/vmlinux				\
-		     /boot/vmlinux-$(shell uname -r)
-VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
-ifeq ($(VMLINUX_BTF),)
-$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
-endif
+# Ship what this directory shipped before the conversion.
+TEST_GEN_FILES += $(BPF_OBJS)
+TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
 
-# Define simple and short `make test_progs`, `make test_sysctl`, etc targets
-# to build individual tests.
+# Define simple and short `make hid_bpf`, `make hidraw` targets.
 # NOTE: Semicolon at the end is critical to override lib.mk's default static
 # rule for binaries.
 $(notdir $(TEST_GEN_PROGS)): %: $(OUTPUT)/% ;
 
-# sort removes libbpf duplicates when not cross-building
-MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
-	       $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids	\
-	       $(INCLUDE_DIR))
-$(MAKE_DIRS):
-	$(call msg,MKDIR,,$@)
-	$(Q)mkdir -p $@
-
-DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
-
-TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
-
-$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
-
-BPFTOOL ?= $(DEFAULT_BPFTOOL)
-$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
-		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
-	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)			       \
-		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) 	       \
-		    EXTRA_CFLAGS='-g -O0'				       \
-		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
-		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
-		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
-		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
-
-$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
-	   | $(BUILD_DIR)/libbpf
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
-		    EXTRA_CFLAGS='-g -O0'				       \
-		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
-
-ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
-$(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
-		| $(HOST_BUILD_DIR)/libbpf
-	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
-		    EXTRA_CFLAGS='-g -O0' ARCH= CROSS_COMPILE=		       \
-		    OUTPUT=$(HOST_BUILD_DIR)/libbpf/ CC=$(HOSTCC) LD=$(HOSTLD) \
-		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
-endif
-
-$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
-ifeq ($(VMLINUX_H),)
-	$(call msg,GEN,,$@)
-	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
-else
-	$(call msg,CP,,$@)
-	$(Q)cp "$(VMLINUX_H)" $@
-endif
-
-$(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
-		       $(TOOLSDIR)/bpf/resolve_btfids/main.c	\
-		       $(TOOLSDIR)/lib/rbtree.c			\
-		       $(TOOLSDIR)/lib/zalloc.c			\
-		       $(TOOLSDIR)/lib/string.c			\
-		       $(TOOLSDIR)/lib/ctype.c			\
-		       $(TOOLSDIR)/lib/str_error_r.c
-	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/resolve_btfids	\
-		CC=$(HOSTCC) LD=$(HOSTLD) AR=$(HOSTAR) \
-		LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
-		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
-
-# Get Clang's default includes on this system, as opposed to those seen by
-# '--target=bpf'. This fixes "missing" files on some architectures/distros,
-# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
-#
-# Use '-idirafter': Don't interfere with include mechanics except where the
-# build would have failed anyways.
-define get_sys_includes
-$(shell $(1) -v -E - </dev/null 2>&1 \
-	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
-$(shell $(1) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
-endef
-
-# Determine target endianness.
-IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
-			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
-MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
-
-CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
-BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 		\
-	     -Wno-microsoft-anon-tag                                    \
-	     -fms-extensions                                            \
-	     -I$(INCLUDE_DIR)
-
-CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
-	       -Wno-compare-distinct-pointer-types
-
-# Build BPF object using Clang
-# $1 - input .c file
-# $2 - output .o file
-# $3 - CFLAGS
-define CLANG_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
-endef
-# Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
-define CLANG_NOALU32_BPF_BUILD_RULE
-	$(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
-endef
-# Build BPF object using GCC
-define GCC_BPF_BUILD_RULE
-	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
-endef
-
-BPF_PROGS_DIR := progs
-BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
-BPF_SRCS := $(notdir $(wildcard $(BPF_PROGS_DIR)/*.c))
-BPF_OBJS := $(patsubst %.c,$(OUTPUT)/%.bpf.o, $(BPF_SRCS))
-BPF_SKELS := $(patsubst %.c,$(OUTPUT)/%.skel.h, $(BPF_SRCS))
-TEST_GEN_FILES += $(BPF_OBJS)
-
-$(BPF_PROGS_DIR)-bpfobjs := y
-$(BPF_OBJS): $(OUTPUT)/%.bpf.o:				\
-	     $(BPF_PROGS_DIR)/%.c			\
-	     $(wildcard $(BPF_PROGS_DIR)/*.h)		\
-	     $(INCLUDE_DIR)/vmlinux.h				\
-	     $(wildcard $(BPFDIR)/hid_bpf_*.h)			\
-	     $(wildcard $(BPFDIR)/*.bpf.h)			\
-	     | $(OUTPUT) $(BPFOBJ)
-	$(call $(BPF_BUILD_RULE),$<,$@, $(BPF_CFLAGS))
-
-$(BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(OUTPUT)
-	$(call msg,GEN-SKEL,$(BINARY),$@)
-	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
-	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked1.o) name $(notdir $(<:.bpf.o=)) > $@
+# Each test binary links against the in-tree static libbpf that lib.bpf.mk
+# built (lib.mk has already prefixed TEST_GEN_PROGS with $(OUTPUT)/).
+$(TEST_GEN_PROGS): $(BPFOBJ)
 
 $(OUTPUT)/%.o: %.c $(BPF_SKELS) hid_common.h
 	$(call msg,CC,,$@)
@@ -233,5 +92,4 @@ $(OUTPUT)/%: $(OUTPUT)/%.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
-EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR) feature bpftool	\
-	$(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32)
+EXTRA_CLEAN += feature bpftool $(addprefix $(OUTPUT)/,*.o no_alu32)
-- 
2.53.0-Meta

