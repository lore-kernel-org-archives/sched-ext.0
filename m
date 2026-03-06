Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15DC392C45
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801353; cv=none; b=RmCGErPUwS0HbD8Aik350WlMhtjQ3z6I5+rE4v6JfMSwZayBN+VckatyWHYfNJ4w/XgP7CisnVztCCgc4CRDDfzeLCNJdnHV+Wzi4wdojxvLAmtzZaTi5+q3icuh/6jgLxMBg7EuUUL6fpKomLcQUGUakMxiCx66k2ZhXiuPOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801353; c=relaxed/simple;
	bh=0OeY0xReBFL8eCyB/FrdWjGk3Mhp+R/qkHPO1eyeEZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roxV0bGkZLNRfy4jY3HeQ8325v9kWHGnhtCYz7LWtK7NuMfK2+LNwJ8m/asJuoGuDBCuglVPPbOs90mx0A62ufmhXYu3hOCThxjnAALaFq1pINWTZRUDo5JjOBvz2zufwYP5zNwKOimfbby0Bu1JJnLUhwwA2Cmn0SuTfT9KddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU5jE1+J; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU5jE1+J"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so7977242a91.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 04:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772801351; x=1773406151; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=usOL8l/KNsMfxD0BXV4D931Ky3sdKsa4TTa5Fbius5w=;
        b=MU5jE1+JAGyl0aIhbXhAGzas+6WwdpV3XRsccsD6LZ2RPPl2P5uPoBOaqmeQm6t9IV
         QEZ9DocZith1fvoC8Zr+aUdFPeuwksBtttmVOGAgPxcKsYxHzA4tmD9HYNZ3WBT8X13W
         dKr5BmAtjzL7Us8xRw7YLmCg2tc32Ttdi+DM4hGPUSE3f3l+eBTO/gsZjxblpi4jzEra
         MKNDgUG4DJjJa8/AnaNpvMHThINQlT+Jy2cxDQFxNt90GIakWfYYIg2Sg25tu52NAisp
         oGQtB5UWQEH/AjUfG3Lsf/yIZImzaY87o4Kko0NwiRpXhv9IYZj+NIPzCLK1m7RkzPay
         7pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772801351; x=1773406151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usOL8l/KNsMfxD0BXV4D931Ky3sdKsa4TTa5Fbius5w=;
        b=Frs6KxrLUaLjcTFaWg736I8tEQBmx7nlZ0bGm2sDZ+HRm55W1dtbP9jNFotDmd67FN
         SgFxzwNZGZzkzJZSeHpzQFqtxtwpBjYUi0p0AjLaNDMf1GScV26NldoF/0NtHdZyU1sc
         rjPc0Wu35PJeJG9YaNDmuAGjm0i6B3PovZXx8BqqJqkxWVVBRwu/nATfHvCmlXBznTkV
         xOVWNV3ExuT9CCN+7s0RA5I/t4Lw9vMos+zOFpyFs80cWiK+S4v2bycxqcdUW4lnP3qQ
         eDtJTrNlJZ5t/jRknK9HXTtTGnMpOybV0+3RfcvrFIHBVM5mXXiQnWUc6w0LLmjOxL/e
         kyNw==
X-Forwarded-Encrypted: i=1; AJvYcCWDcEpWrxXaMxS4BK2ibAvyYXcpws47/pi5KWbvVp+17Au4rQ0J4EIkmYa17/Rj50b0TF5v2rF8xz8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ0z0U3BgxmTsT+QwXbn08FzQTtHfNUqDgeOh8He9tvieOu2ux
	elL+5DTu85NIDwa0yx+uP5Yr47IV4f41sI1EwN9NXQgjdEMLRqfApaZY
X-Gm-Gg: ATEYQzxUD/TcdJ4YFSUl0dvOIA5xnO7X9o2xYDWCPSGNFU8Rgl2CyW48MrYdeRva+on
	JoZxYHvOajt847p/tSJNM79j69O4fmcIN9P4OZOoDlu2kjuJT8lVOQzxS2drYMm7o7b+kiYPh+V
	IW6QO2rlMzkiB11p1GmL/eIq5av0Kj7+yBnIhl18Fw3/XIyacvUovMFp1MfCpYCJ6ABUc5Dwvwv
	C19QZCX5Hu/eJWxbZ4USxcMmVwbZ53gKEsvQRPnh6hThYerRFGdsxzuWpO1eGj418z90Nltq68b
	tQiaRLhCyjF5LrDwo2Lmb3J5tmREkpRMqXi0VnHTGJNGYkFPfpJW3WAMER02wx8oHXu9bGMUL5+
	kifaaX/sHTizra5VJR1SqgQzMJOtgKzXi7IvEm6oVv9MTQaMRej8glo/Ng7kNtA5d/wX2Y1J6O3
	TuuzcPR2zqk2vSXM+b24KW7r1LWEpgZXcoych8VT2zfyccnZYDl/8A1gTt73S9qwJHz/c6/UxbK
	DI=
X-Received: by 2002:a17:903:faf:b0:2ae:7f7e:93a8 with SMTP id d9443c01a7336-2ae8248ab08mr22623655ad.51.1772801351191;
        Fri, 06 Mar 2026 04:49:11 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78f77sm27712845ad.21.2026.03.06.04.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:49:10 -0800 (PST)
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
Date: Fri,  6 Mar 2026 20:48:58 +0800
Message-ID: <20260306124901.2653465-2-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
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

