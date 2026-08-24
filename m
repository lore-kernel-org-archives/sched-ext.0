Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515C2931FF
	for <sched-ext@lists.linux.dev>; Mon, 24 Aug 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586671; cv=none; b=Uh8TpEcFHxdB48TOW2LuRqCM1QlAwLTlL+1AH0DUgdWnHjV/7bCjT9RPNpteBWJpwggRcn8de/35NXkd3QIaIM8YfIdsx2AI7rtwEIVlaoEl4u2lywH+kBI59dM2002XjQt/CWxV3uUJDtpYC5R2WHbPaoexwt2UngVZpJGNRvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586671; c=relaxed/simple;
	bh=F6ZPFcKc37/XdcHXAZR51aFVceH8fjB+VhYGkDmtqh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSxGXQvioP5xy8S8dcYRUJv9pX5bTIGz3GMTwU4PoZlbMp6SN4IMUOj9jUQIRzmaluVJ29U6s9u+D3nXyH9Gz26jLvJGLBXA/pcCYziyj1NQOVViNbn980IaTdpBxHtI8nqqmhLaBqL7Fk7vtlxEVN9lYVIwxm4CwONCY+z6ZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYo6gWwZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYo6gWwZ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3204298a91.2
        for <sched-ext@lists.linux.dev>; Mon, 24 Aug 2026 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787586669; x=1788191469; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dDgcyd9VHUAvs5ZS727Gj7GWyKHNZzMKf/E4MK7RgPo=;
        b=IYo6gWwZGNvorU0ndbyW6C5NvTxzT5N7fZHB1uOdf3yIiXSgLr24lQ/nigl95GhnAV
         480KLVYBPyzEG4Ep92k0zSs7eGWIaqhsa4liT8MU22KfNNtrJi+fpdHxnpUgtjfS6blt
         jnRunNsxlGzep6m0Crnh5inXHZtb49JLceHU4irU9QZUE8xzyH+jy6O8feiKPNk59A+z
         xdYpt3KIf9z8qPBEhAMKX46cA0/zd7KfTI3jYcWnFUC/RfSXHTkwaLXcjJhLmtqIkU+E
         OT7g8JMnG06JT+pjjHjyAzV+Y3PDC9t4FomArg/YVpYi2ObAmcW4E0y64AtS/WbW8WAv
         Mk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586669; x=1788191469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dDgcyd9VHUAvs5ZS727Gj7GWyKHNZzMKf/E4MK7RgPo=;
        b=aFxizgsUGROddga3WYfaQrHzjX4HR8RRv0p10jHLQElTHH2/+Ef7lwo36XCcogIOI9
         +wqSs6Y7/1xWkFSrFcZYbJf/6XwbZpVRAP53y2qGpOfnqIFrlzDv/xjllqi8wur+KGm8
         /slHJodEzQPgscKIGiTau8QbDb9Oov2jk2fs68voirsEI6d9NlQ8lVgeCRUt7eiQrA2E
         9TIhqfa0aZg1pFlsTLlfbLcnDvbijFqsHBubP2iP8FPKMx9xwtpMmj0VMm6DABWeb7x9
         BiGhCCcb+FBLp4PB4r2XRzcS2xdXcDOu+MvswGSSt/J4WZ3B9BaFouWuc7iDlaPOC/em
         qYjw==
X-Gm-Message-State: AFuF++kHLL89qdAiNk6P+a+gN9RmEtu9ZF9BwHDsyCOp+iM1hL0VGr56
	HELXUSAhhrZKcLi3OZsEsa7AT4a/sw3U8EyNRM0aW6PAIhm0O7qMDahw/6o/tA==
X-Gm-Gg: AR+sD11v7wTo67TrWN89pBZK2m5Rpcq49APK6gKzrvBlpmIpE8eZj1p/HlPi8hWgtNs
	FvPEQBkF4jHW9eK/CrRTzBLHqmOdE5uuHVDeIGcVaUUbIoJ1bItr6nNlESkP0U/88AZQKLI0djK
	VsOuP2fn3+WH/Djw9ZCpHdDAhGlTvEwl1r/hhx/a9geugu8gBLropd5JRHvwi1uaXEDvKSRqhQw
	z6xvlKG1yIVUh0MtAWNvxoZ8GIEitqm6r06mjrSey+rmv/5V+Dt82WKkiLncC4ixtQ2gnFrks4U
	+gfd8jLUcsiDp6VeORpahCN7+aAdLONFYi1H6snNlqDcBnVADYT3UR+02hYQ3D4Fxw/9XiEa35x
	roLg72ggrwkMoSgCE0R2A1FqaWtncNa9Pe9dxw6iFvkWUNdop9GUmM8NtWgTL60qX7/1IhM4m3Y
	i2hPzNlfvru5sG/CFJ2+pzv0WdKbIQpXZ1wPL0nTP0nVBxn5F0FyyWI1BB2anS2GOmIJnvMZwsA
	bYGeRQ9oyH6Wr/wHXnogT6+ND4BJ39IorJ4nSklKY5S2JUtL3y9Kybk8AVxVI5vOFLwzsWm
X-Received: by 2002:a17:90b:4986:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-395c33cf295mr49835030a91.6.1787586668784;
        Mon, 24 Aug 2026 08:51:08 -0700 (PDT)
Received: from cchengyang.duckdns.org (1-164-86-245.dynamic-ip.hinet.net. [1.164.86.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645bf2e6esm30690a91.16.2026.08.24.08.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:51:08 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH sched_ext/for-7.4] tools/sched_ext: Skip scx_lib_init_probe() without CONFIG_FUNCTION_TRACER
Date: Mon, 24 Aug 2026 23:50:04 +0800
Message-ID: <20260824155051.20841-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_lib_init_probe() is a fentry probe auto-attached by every scheduler
via SCX_OPS_LOAD()/SCX_OPS_ATTACH(). Without CONFIG_FUNCTION_TRACER it
can't attach, and skel__attach()'s all-or-nothing semantics takes the
whole scheduler down.

Skip its autoload when /proc/sys/kernel/ftrace_enabled is absent, and
skip disabled programs in the post-load struct_ops association loop so
it doesn't try to associate a program with no FD. Reproduced and fixed
in vng with a CONFIG_FUNCTION_TRACER=n kernel.

Syncs the fix from https://github.com/sched-ext/scx/pull/3758. As
discussed in GitHub, once we stop supporting pre-6.18 kernels, this
workaround can be removed.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/compat.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 7c12df45fdba..faf608cbed55 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -361,13 +361,27 @@ static inline void __scx_ops_assoc_prog(struct bpf_program *prog,
 }
 #endif
 
+/*
+ * Whether the kernel supports function tracing (CONFIG_FUNCTION_TRACER),
+ * needed for fentry/fexit BPF programs to load or attach.
+ * /proc/sys/kernel/ftrace_enabled only exists when it's compiled in, so its
+ * presence is a cheap proxy.
+ */
+static inline bool __COMPAT_function_tracer_available(void)
+{
+	return access("/proc/sys/kernel/ftrace_enabled", F_OK) == 0;
+}
+
 /* See SCX_OPS_OPEN() above for backward-compatibility handling. */
 #define SCX_OPS_LOAD(__skel, __ops_name, __scx_name, __uei_name) ({		\
 	struct bpf_program *__prog;						\
 	UEI_SET_SIZE(__skel, __ops_name, __uei_name);				\
+	if (!__COMPAT_function_tracer_available())				\
+		bpf_program__set_autoload((__skel)->progs.scx_lib_init_probe, false); \
 	SCX_BUG_ON(__scx_name##__load((__skel)), "Failed to load skel");	\
 	bpf_object__for_each_program(__prog, (__skel)->obj) {			\
-		if (bpf_program__type(__prog) == BPF_PROG_TYPE_STRUCT_OPS)	\
+		if (bpf_program__type(__prog) == BPF_PROG_TYPE_STRUCT_OPS ||	\
+		    !bpf_program__autoload(__prog))				\
 			continue;						\
 		__scx_ops_assoc_prog(__prog, (__skel)->maps.__ops_name,		\
 				     #__ops_name);				\
-- 
2.43.0

