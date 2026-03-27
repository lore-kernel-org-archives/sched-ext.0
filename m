Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB540626B
	for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635714; cv=none; b=CwZHRmaJlvX7TuA03OQPkB/uCMjpVuGTTITjDqvSsumqlgZvXXnw/5CnTnd1KdYsm08gDpcsZGEPRJRY+nqQ3GIfqhcNBP1bZT8uRTvoBWMVSUuqprBnUH+DaTKYf1TfNVApWl3Aq+9dHVo+xBX+lXcmVBN8fVuhiDphLc2hIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635714; c=relaxed/simple;
	bh=VQWuA7ljFXLKvtzwI40uRYEpWCQWicResLl3H1rgYK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTsZ5xjj4XEVtTxt+iC04fO7p9rK6rwJmZmtBtZjvDzaxNmaLobf4iim2a7clVivmlZa27Xhk8WA7zVWeIsr/qDS0HVD/sKoHTzeLLbIUi+Qo5Jqv7xurEor8VJkams9kzFmELj0KkapBp7dZsAUOHumuDhUyM5lb1qDAEm8szY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYAKsjgY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYAKsjgY"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8296d553142so1300182b3a.3
        for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774635708; x=1775240508; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l5pdfkhflWKrLQ74AKrNAluhWj2W69dTMiem8rJoksQ=;
        b=dYAKsjgYfD2UcD5YHE6b4hQYoELukdL45RcExoiPmwFAYXUyoIA/SF7Hpfyq3PXBBF
         XZW2+Wq5JwJCD7+E2bpYzoeUfhDH6kSiaS4Uqtc7AO6Ojm7dUEkgE5XjtxAjgixj/T+i
         Lb7mR4VQblUatAUIe2b/akqwKetlABjUZcvsP20COzdPGwfLnPl4J2MVXXB8g7LPt1Jg
         3UslQTl05VdR0kYjanqb/zPe0yYTyS7sWxW7kXN5/qZKHmSnHGepAA6rRCBg/rIfg3dY
         mD0avlY9zolGuoWZ7b8BjxRDK5owp5QWVlqJdUvROgOQfBBLAyDP1KJlEzGMzQxap5O/
         4Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774635708; x=1775240508;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5pdfkhflWKrLQ74AKrNAluhWj2W69dTMiem8rJoksQ=;
        b=eEC9EpH20qFFay0+jP4EYWFbfwnk1OYLg4UgeH/xihiPvT0I9vSxE0FVkuoVDmPrli
         fc6avMrL345dJKLb1Lhp72XoFyiWev/vDa6y3W1Rx8E5TKbM0egGiY/4MTWQcdc5zF0G
         HV2cPbKTz7ooYb6YHtTEMtsdFk3+lwhKR9TezYvCblkzxy9tzg1WiBIgEbEkUiwOesUG
         Wzt+fp8JiXfZAWLBOtGOg3ctOgosExbE7yBc9NNp1s2rfnznzyERM506P3QosXjIRXdq
         FreZJnUPJMr9334Pu+Ak/a/KShQ1jEQjqAq0Jnm2MoCgij1nVm9q6eWlIzP1gu1VjfaU
         9ocA==
X-Gm-Message-State: AOJu0Yw4qwL6N6zqiODm/o5oLzi0BHl6dlBXLQxMC0ZqkUHSRfKLDxlQ
	wb32J42iJvdIA+HT8B9MY4JAUTAc9BSajEJi2l+rALwEy3aRzcK238a+
X-Gm-Gg: ATEYQzwlJdZETRjIlVNNtMEokdBjh+6x7HmrUccCYqr20ka7+ZrwkbVpKudAxQFzJJp
	ULLmjqfR/GIl5oDF5vuSB0jSRO6O4060EMvzZEm+/qhj5yhV90gR9t5O0LqeRRJWIEE0DBTLJIZ
	+5+ZD7JCelSPrKmpZqh1evKi0BTdJNH0LpxohpR+eQmYTB4+3AhmMbnzkADozM7eCsDc+4W0B7M
	l1q6FHxSiqU/+Kh0cIWZujfDma/ld/jkmRWLF5FbXpDiUgdp0qo+D+lvqeVwdg2O/tcTcN9USUp
	mQuQbhW60BuSHTu5gM5s9x1VPJM+HRfEEMe0Rsd74UnGH9MJrfQmKmmdfGxAU5C5AVQo+kN5N7s
	dH+SFk0BVMHGiCfZ/pLi4kIRCHCG6YNidxq6EMkiab4qDeIWPsS5RtYHs7d7whhuYq/mA36odwu
	jrltjXutvxh1CKbvJhu0azTYoGfDw=
X-Received: by 2002:a05:6a00:a113:b0:829:8942:2c93 with SMTP id d2e1a72fcca58-82c95c27a9cmr3367213b3a.9.1774635708143;
        Fri, 27 Mar 2026 11:21:48 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:367:9d63:195c:593f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d400f62sm5669462b3a.55.2026.03.27.11.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:21:47 -0700 (PDT)
Date: Sat, 28 Mar 2026 02:21:42 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] sched_ext: Fix print_scx_info() build error on
 !CONFIG_EXT_SUB_SCHED kernels
Message-ID: <gunjxqantrttj335ai73vkvddqj5swkkfwvm5abkwprhiwjwwz@wktl537f5qim>
References: <20260326081021.687711-1-yphbchou0911@gmail.com>
 <tmzdbaqgbe3vypfbm6gdih6svfs6pyrdpnklgmmwc47brnika6@vtcswuax5dxq>
 <aca8A9UdYV8nElsB@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aca8A9UdYV8nElsB@slm.duckdns.org>

Hi Tejun,

On Fri, Mar 27, 2026 at 07:18:59AM -1000, Tejun Heo wrote:
> On Fri, Mar 27, 2026 at 01:35:53PM +0800, Cheng-Yang Chou wrote:
> > Hi Tejun,
> > 
> > On Thu, Mar 26, 2026 at 04:09:15PM +0800, Cheng-Yang Chou wrote:
> > > scx_task_sched_rcu() is only available when CONFIG_EXT_SUB_SCHED is
> > > enabled. Wrap the call with #ifdef CONFIG_EXT_SUB_SCHED and fall back
> > > to rcu_dereference(scx_root) for the non-sub-sched case, which is
> > > semantically equivalent.
> > > 
> > > Fixes: 60d4b17e886a ("sched_ext: Choose the right sch->ops.name to output in the print_scx_info()")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202603261453.8kiJImYo-lkp@intel.com/
> > > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> 
> Have you tried reproducing the problem? This is trivial to try to reproduce.
> You aren't even doing the absoulte minimum. Before sending patches, read the
> relevant code and reproduce the problem. I get that AI makes it easy to pump
> up the volume but try to reduce the volume and improve the actual
> contribution. Otherwise, I'll have to mostly ignore your emails.

Actually, I can reproduce this error on my end with the provided config.
This patch does fix the issue.

I'll make sure to include the test log in my future submissions to
avoid any confusion.

Here is the full log for this reproduction:

> Reproduce 
$ git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 2>/dev/null
git fetch tip sched/core
git checkout tip/sched/core
From https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
 * branch                      sched/core -> FETCH_HEAD

Warning: you are leaving 1 commit behind, not connected to

any of your branches:


  43cb4d487c60 sched_ext: Choose the right sch->ops.name to output in the print_scx_info()

If you want to keep it by creating a new branch, this may be a good time
to do so with:

 git branch <new-branch-name> 43cb4d487c60

HEAD is now at 265439eb88fd MAINTAINERS: Add K Prateek Nayak to scheduler reviewers
$ b4 shazam https://lore.kernel.org/r/20260324120313.12632-1-qiang.zhang@linux.dev
Grabbing thread from lore.kernel.org/all/20260324120313.12632-1-qiang.zhang@linux.dev/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
  Added from v2: 1 patches
Analyzing 6 messages in the thread
Analyzing 0 code-review messages
Will use the latest revision: v2
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v2] sched_ext: Choose the right sch->ops.name to output in the print_scx_info()
  ---
  ✓ Signed: DKIM/linux.dev
---
Total patches: 1
---

Applying: sched_ext: Choose the right sch->ops.name to output in the print_scx_info()
$ mkdir -p build_dir
$ wget https://download.01.org/0day-ci/archive/20260326/202603261453.8kiJImYo-lkp@intel.com/config -O build_dir/.config

--2026-03-28 02:06:58--  https://download.01.org/0day-ci/archive/20260326/202603261453.8kiJImYo-lkp@intel.com/config
Resolving download.01.org (download.01.org)... 2001:288:6:91::a87, 2001:288:6:85::a87, 23.220.230.175
Connecting to download.01.org (download.01.org)|2001:288:6:91::a87|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 258088 (252K) [text/plain]
Saving to: ‘build_dir/.config’

build_dir/.config
100%[================================================================================================================>] 252.04K  --.-KB/s    in 0.02s   
2026-03-28 02:06:58 (15.2 MB/s) - ‘build_dir/.config’ saved [258088/258088]

$ make W=1 O=build_dir ARCH=x86_64 olddefconfig
make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/ 

make[1]: Entering directory '/home/eric-wcnlab/dev/sched_ext/build_dir'
  GEN     Makefile
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/menu.o

  [...]
 
  CC      kernel/sched/core.o
  CC      kernel/sched/fair.o
  CC      kernel/sched/build_policy.o

In file included from ../kernel/sched/build_policy.c:62:
../kernel/sched/ext.c: In function ‘scx_vexit’:
../kernel/sched/ext.c:4800:9: warning: function ‘scx_vexit’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

 4800 |         vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
      |         ^~~~~~~~~~

../kernel/sched/ext.c: In function ‘print_scx_info’:
../kernel/sched/ext.c:5719:15: error: implicit declaration of function ‘scx_task_sched_rcu’ [-Wimplicit-function-declaration]

 5719 |         sch = scx_task_sched_rcu(p);
      |               ^~~~~~~~~~~~~~~~~~

../kernel/sched/ext.c:5719:13: error: assignment to ‘struct scx_sched *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]

 5719 |         sch = scx_task_sched_rcu(p);
      |             ^

> Apply patch here

$ git am fix.patch 
Applying: sched_ext: Fix print_scx_info() build error on !CONFIG_EXT_SUB_SCHED kernels
$ make W=1 O=build_dir ARCH=x86_64 olddefconfig 
make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/
make[1]: Entering directory '/home/eric-wcnlab/dev/sched_ext/build_dir'
  GEN     Makefile
#
# No change to .config
#
make[1]: Leaving directory '/home/eric-wcnlab/dev/sched_ext/build_dir'
make[1]: Entering directory '/home/eric-wcnlab/dev/sched_ext/build_dir'
  GEN     Makefile
  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  CALL    ../scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  CC      kernel/sys.o
  CC      kernel/sched/build_policy.o
In file included from ../kernel/sched/build_policy.c:62:
../kernel/sched/ext.c: In function ‘scx_vexit’:
../kernel/sched/ext.c:4800:9: warning: function ‘scx_vexit’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
 4800 |         vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
      |         ^~~~~~~~~~
  CC      kernel/sched/build_utility.o
  AR      kernel/sched/built-in.a
  CC      kernel/locking/mutex.o
  CC      kernel/locking/semaphore.o
  CC      kernel/locking/rwsem.o
  CC      kernel/locking/percpu-rwsem.o
  CC      kernel/locking/mutex-debug.o


-- 
Thanks,
Cheng-Yang
