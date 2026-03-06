Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980B3A9DB2
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805819; cv=none; b=sF3uaGAIx2b8q3rCx+RZ5FtyC74+BDejP30ay9Fl65GnEABxgGfHeWQK2hi5t91SEwCbFefFuctLE0+a3r7IcVfQdFuAJ+4BAsz91UiFhsQ/MbN9US1hqcyE64Lxq5CpY5LqbMdMtMbG2GK4QpmPYYAfo4DO84ZUnpomeL0XDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805819; c=relaxed/simple;
	bh=0OeY0xReBFL8eCyB/FrdWjGk3Mhp+R/qkHPO1eyeEZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAXsNblIPhXxNakhxdLx162EF8bZ0fppBSTXMDiCsvwhrVCMuV/XSsfAPfDhYAF7VLDYkO7lmD6YfVyEAg9INAArADmBhKPLht/2RJ0vVtAdYZIXziUwvqDmGANgPWiXzh04+mm/XWslCJNb5aZfQNPhH/VZCT+yxzTHu4Dxd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYeUh7Z5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYeUh7Z5"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c738fecf349so718404a12.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772805818; x=1773410618; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usOL8l/KNsMfxD0BXV4D931Ky3sdKsa4TTa5Fbius5w=;
        b=TYeUh7Z5XAkTsnvDBAYeWHsdSU9epftS+D2cUzpjzTh3x0U7Jir+TPa6uEa26pXkxR
         a+35H1TwhoBN7VvL7RHomhqKiKO6D5T7qne1z/aJohDRZO22OJL9g6nFL+GXkw/gFloy
         +xGNNH55yXOBQEG2lnOSMgi97IrF9p5A3J8zvL8DRvveKP77x1zBpxcbVCzFytV2nXI7
         qwwQIfXgO+Jg0VTCVPj438sx4FsZgOFLlPKm1kSXbhVza7MNxrl7LQj5IVXFF35xuSGn
         94QzFC3WZK1C6zDwCjpxenDoistgPwWqdhzWF8a2V32rQsVqXUkNzq2Yt3CEZmFT4EO0
         7vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772805818; x=1773410618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=usOL8l/KNsMfxD0BXV4D931Ky3sdKsa4TTa5Fbius5w=;
        b=xG7YUrpyRcm83awPwD9xld8/1CdLy7gtjXr6DTVnsqp36jD2zrWhpCqVc4o0p0TK6g
         JwSp1zlUsI5bYTsEUASs2+ARpCGVupX/HP526Qdv1jufaiCH+yizP2fYy5taf/QlYtHA
         mhaiw80INUBE37vIci+VTOTy3oxgaofjD8VyZXYc1uyF/h5OxzZA97K46zwiPJe25KzF
         FpoPonUQgV7kLCdm92o7pb9GC3tzJzt1paEH03n8ddzTJRzkZW4IMR+/+V0MBOkGoW7O
         dveQCXF/zmKm6tE2Msa8HlPczGhZIeMgF9r47wLBmJLtEYiLffNQN0enIjdIqUOjT07h
         8ORQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRT3mDid9bj7fdgInX7UBeDcGi1afRoTp+CP8LnP+uDg0LoQcBSNu/ShgYCrVjrVAscNF1OtMYpUQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5PTzx5wWomTGAT6DkspaEmBkurtkAdPsW1GRBHxTVeYTY0tTl
	SqmCer+4tfj/EnvC1NmV01MCOoQ65syJ49wYOgvL9nhdm7PLFoFbbfxz
X-Gm-Gg: ATEYQzyKxJAnfjJktxPZm+iisxPE7U9Hy4QLMJTaL8CpKAnp8n0YR940TwHBzVNsdxs
	dd/vmeQIJaN2k/qfk8elBweN9721KFnKPEBfsMP8EYAjfMc9bE93LE6qpShgeakGvCd8BEqIvhY
	85DWeVcarDgyqIESGf6pl1rpd3XEsiMv+SApA9/GmhRo74oaSiPImFhM7VKhcCP6y9/yKvOkTMw
	fSSFjo0Es7w5UUyEwHRdjPLs7F17tt953na3brq8OIgdp1kMYR+9karC2m+TYdTcXKg+pDSYAnN
	pGSeEBoBVAc65bDup0rYQM0LixChS4pZK6IXKQE+PBqPM0nneMUdP9+c8FvdX87GRwXIaVfzUkv
	Y/CdS6gXF+L7ur75PuafZYfcWnj9kDYxrI3J8OwgW4fEBFd35JTERV6a8L6XBcIa90C9V5thzsb
	QnYJ0m55CVmOLvEMY4Oap+9Sh1YqbSun52a8AdSCwi4xnZDi6sRI5ddB6T0NKw3LIZ3yBhxcTKH
	Jw=
X-Received: by 2002:a17:903:3a8b:b0:2ad:da28:8c7a with SMTP id d9443c01a7336-2ae829622bemr21398275ad.8.1772805817813;
        Fri, 06 Mar 2026 06:03:37 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ccb6csm29134715ad.92.2026.03.06.06.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:03:37 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: tj@kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kselftest@vger.kernel.org,
	Su Zhidao <suzhidao@xiaomi.com>
Subject: [PATCH 2/5] sched_ext: Add comments to scx_bypass() for bypass depth semantics
Date: Fri,  6 Mar 2026 22:03:22 +0800
Message-ID: <20260306140325.2710927-3-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306140325.2710927-1-suzhidao@xiaomi.com>
References: <20260306140325.2710927-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Zhidao <suzhidao@xiaomi.com>

The bypass depth counter (scx_bypass_depth) uses WRITE_ONCE/READ_ONCE
to communicate that it can be observed locklessly from IRQ context, even
though modifications are serialized by bypass_lock. The existing code did
not explain this pattern or the re-queue loop's role in propagating the
bypass state change to all CPUs.

Add inline comments to clarify:
- Why bypass_depth uses WRITE_ONCE/READ_ONCE despite lock protection
- How the dequeue/enqueue cycle propagates bypass state to all per-CPU queues

Signed-off-by: Su Zhidao <suzhidao@xiaomi.com>
---
 kernel/sched/ext.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 56ff5874af94..053d99c58802 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4229,6 +4229,14 @@ static void scx_bypass(bool bypass)
 	if (bypass) {
 		u32 intv_us;
 
+		/*
+		 * Increment bypass depth. Only the first caller (depth 0->1)
+		 * needs to set up the bypass state; subsequent callers just
+		 * increment the counter and return. The depth counter is
+		 * protected by bypass_lock but READ_ONCE/WRITE_ONCE are used
+		 * to communicate that the value can be observed locklessly
+		 * (e.g., from scx_bypass_lb_timerfn() in softirq context).
+		 */
 		WRITE_ONCE(scx_bypass_depth, scx_bypass_depth + 1);
 		WARN_ON_ONCE(scx_bypass_depth <= 0);
 		if (scx_bypass_depth != 1)
@@ -4263,6 +4271,10 @@ static void scx_bypass(bool bypass)
 	 *
 	 * This function can't trust the scheduler and thus can't use
 	 * cpus_read_lock(). Walk all possible CPUs instead of online.
+	 *
+	 * The dequeue/enqueue cycle forces tasks through the updated code
+	 * paths: in bypass mode, do_enqueue_task() routes to the per-CPU
+	 * bypass DSQ instead of calling ops.enqueue().
 	 */
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
-- 
2.43.0

