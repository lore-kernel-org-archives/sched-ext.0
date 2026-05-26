Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BABE3FDBEA
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803495; cv=none; b=KUkjhATB9lblgmPkFNdgVwf0GwcJUgIfZEjr2AuhyR7A7tpHKpFYE7s89G3H9q0W7Bfb+Miqr9fk40w479MdRA2jg0VXVUJLHEIF+C49qe4sAb93Ock6iiEoDIwjMtQkKLsv8G0rZdpcF7RN3+npI6yyJeqdmgB2OSrt5YyKYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803495; c=relaxed/simple;
	bh=g3XL6UHQ5X/eraQCFiYaUWLICWC+349yDBHJ+dUy8ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byTbnec2LvaML1qYmYJB7l6UC7TIqWWL65kSXYjMom5aJhddcFhXkXrb0I91xlOzYBg9FHd50ez6WrWpccqFtAeGm07GlIxUIrBX1DWVRWaNHNEswAPAH5/WWbRLlF2nuHj34iFM01ri6CgzblbOLMaX5ayujMlJemos5YqY0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMZv/7iz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMZv/7iz"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so4676116b3a.2
        for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779803493; x=1780408293; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vwSbnjkxGnXGaLUaGKOC4vnl3KT7tW87Ya/uzx+HPaI=;
        b=LMZv/7iz7iabdYPSBpwYaiy5pge6e9yOMfe67/Cm6BP1QiCNct1+BbFO+FtqisglIP
         yk1TUHn7usKkICz74hNRSmZWEytslcqVbpD7e7lQfNlsraGCm7ficAGURVY1WvSu6+Le
         fu7KlxwTygtLfYyBfWSWHoSjFnZD+UrTuuDpziqdRGg6+rKhOBiBOm/NnogtnW+4MM/h
         NAHWm0med6vBsJgSGsf4e+WK/g8RotQuel/QPFBsSGXFMmSVaWkMU5WLYIp6Pt9qfSmd
         s27FT6Io2bcYVktuRT8e00ii1mxdbY27/jC+hT3BYHg9hk5R9G6yX5SQi1Nnx+2heexV
         A3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779803493; x=1780408293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwSbnjkxGnXGaLUaGKOC4vnl3KT7tW87Ya/uzx+HPaI=;
        b=TQNd/M+0pZD1Hqgz2r9jIXCP/00tWdu0gtFIs5OurOq7Lhvnulk+YjgakSigQS6+zO
         CXUGF0/OChgieBOv1R9fwOi46fQEB025mNBTtXBEck0YtSRaqQteQ0+pikFpsACcz9GL
         RglFrIeMpX6jEdflheBTYve5CIYbLWtoZDlb1t7SEWOB3CwBN0C6vQiPt+8K4PLRZxGU
         xt9+5FmWBmV5MtK0zyzOHn4Ej+OaXDuvvdozAR1KfRBP052KIkrS44+OaJILM16tFReC
         0SBJTGPVYH6QVKnGf2xs+Ocsl4yD6chIAkgC4EN2ozyc2mLjztkdXqQvMBXKHhKRYYHR
         /+5w==
X-Forwarded-Encrypted: i=1; AFNElJ8KMmRaJBfR8RtijrSY9yTkNBsePQIxDd5OK6P73sxp+AFNwgV0g6beRbnjpRV1gkOqihTVUdnAB8w=@lists.linux.dev
X-Gm-Message-State: AOJu0YzIL3P/b6p1346L6Q/Zm/I0Hn5/78hTjhJPH/I+JlyPQo65KKtF
	9M646Co1Iep3co5zOhiwMfM8oG7/p2+qdnf4792GjrtMofnZHNEGfSai
X-Gm-Gg: Acq92OE0Fjr3kxp05YWvK8lFRjubmn8hE1fdyF06UG/qiX2PIdTItCi/DmRQiqm9i9N
	Hy26NXZYwtdkpbGOXY+PgJMbiptLAiTPf4InZE2WhCS4q83PyMHhU4xkfxqSwvtMKtpKLrI+Rms
	pBHBRole/cu4MBmR9rH6KC2q8bDmcVxuc0JkPlBpAiStBsp9ROa1ph2rvy3TLUKbNqWJFn3lE/L
	Zc9eNspc9mLclHXcvtChtUM7kLy4yTwzAX1tRVj2ngJTc/hIoG4rsjdX1KBhhDHL39R5je4gsKE
	vCL98sqwiMIhvs+w+pz7dnWR25qQomZ90oDBqqU+o2jddZ30P4RDovEZ6Ja0feWt5VJC05fu920
	JJUpQSX2JSRm0hbAU0QValNOEK1LjLqFEnYCl3aOT2UDi1s4tqT9VuqgED0cLaCDAWDFPLPRygn
	sk9hMk9Issw28xghJePbcex3qGFXNDvcOxm+rw/3sW+8NtlJY=
X-Received: by 2002:a05:6a00:908b:b0:83d:446c:2a8c with SMTP id d2e1a72fcca58-8415f406c9amr18309716b3a.25.1779803493442;
        Tue, 26 May 2026 06:51:33 -0700 (PDT)
Received: from DESKTOP-QGNVECK.localdomain ([139.159.170.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fb3083sm12523110b3a.43.2026.05.26.06.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:51:32 -0700 (PDT)
From: Zicheng Qu <quzicheng315@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	enjuk@amazon.com,
	emil@etsalapatis.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: tanghui20@huawei.com,
	zhangqiao22@huawei.com,
	quzicheng@huawei.com,
	quzicheng315@gmail.com
Subject: [PATCH] tools/sched_ext: Fix scx_show_state per-scheduler state reads
Date: Tue, 26 May 2026 21:51:23 +0800
Message-ID: <20260526135123.1892092-1-quzicheng315@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zicheng Qu <quzicheng@huawei.com>

scx_show_state.py still reads scx_aborting and scx_bypass_depth as
global symbols. Those symbols no longer exist after the state was moved
into struct scx_sched, so the drgn script fails when it reaches either
field.

Fixes: 5c8d98a1b4de ("sched_ext: Move bypass state into scx_sched")
Fixes: c1743da43cf5 ("sched_ext: Move aborting flag to per-scheduler field")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 tools/sched_ext/scx_show_state.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show_state.py
index 02e43c184d43..446d82807f90 100644
--- a/tools/sched_ext/scx_show_state.py
+++ b/tools/sched_ext/scx_show_state.py
@@ -27,18 +27,25 @@ def read_static_key(name):
 def state_str(state):
     return prog['scx_enable_state_str'][state].string_().decode()
 
+def read_root_ops_name():
+    if root:
+        return root.ops.name.string_().decode()
+    return ''
+
+def read_root_field(name, default):
+    if root:
+        return getattr(root, name).value_()
+    return default
+
 root = prog['scx_root']
 enable_state = read_atomic("scx_enable_state_var")
 
-if root:
-    print(f'ops           : {root.ops.name.string_().decode()}')
-else:
-    print('ops           : ')
+print(f'ops           : {read_root_ops_name()}')
 print(f'enabled       : {read_static_key("__scx_enabled")}')
 print(f'switching_all : {read_int("scx_switching_all")}')
 print(f'switched_all  : {read_static_key("__scx_switched_all")}')
 print(f'enable_state  : {state_str(enable_state)} ({enable_state})')
-print(f'aborting      : {prog["scx_aborting"].value_()}')
-print(f'bypass_depth  : {prog["scx_bypass_depth"].value_()}')
+print(f'aborting      : {read_root_field("aborting", False)}')
+print(f'bypass_depth  : {read_root_field("bypass_depth", 0)}')
 print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
 print(f'enable_seq    : {read_atomic("scx_enable_seq")}')
-- 
2.43.0

