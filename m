Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975311;
	b=uHne1RnVfj+2+I63+g11xK4006PEMwml+1kQIORTZT/7TIvwDuyqw8QCsll6KfOF1CsI
	 rKqM3DRTsxG8iTfZcqjWTKN9BYgR/UcMpT46ElXAGYhf84Qc5teky1plfkm5ds+hQXtfd
	 ubC87JsK+yXWes13e8ewA/Rlgs+IAaRL3q7+ZQ7E9Cc9E8E3+LSzws621i3NCGW19G04P
	 n1ONptFIv0uU/4D4np3TNKU53XmjdKSqyYAv/NQUgB1m4eLek8ZVO+C3rCHi9aSVo7GiX
	 N0eoi7PZUrnDtySpfoJ2EDjTmysOmJdNwM5V7KT2edKx6c4udvI/dMBN/hSdgGrKQDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Xi81y1XZW609wk/sWs6sIq2iQGR+N/bC4UAGbPKuq4A=;
	b=g77b7chEjHOdAKYWqlpkycmYz+E4zaP6xRuTBw4R7NBY8/uuSX6mPzcC4ql9uz3/GKPz
	 682Dj/vbRKQbTi12Sy+c0kWf8KFNQhxQjgEk/bX9Lhnw668FOQUBK4/s/cDyqEdLvm3bt
	 YXV04F56pWvGvrGSbRZjN3Fqv5WkJ8sSjV0o+lRh8DjyhqeM9O6jTDWsxaIJrulR3wU0m
	 NNj28z0x0UKd3wUXIUi+8PqM7n39pIk2eV5yhjq2o5V0LGwoPAXYyboaLWCnfmzFORQk0
	 qIOQ8/sYvvJMC14gK0SWpxLxy0E0rRBlTETi7slriNGbuEjJdVmrg7aGM5eqIVD9q5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fLu5bTwf;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2026606A32D
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 14:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2026606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fLu5bTwf
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc147d86bebso525020a12.0
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 06:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793975310; x=1794580110; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xi81y1XZW609wk/sWs6sIq2iQGR+N/bC4UAGbPKuq4A=;
        b=fLu5bTwfluzpji/pLkCmHZKVowoDqf9W2JEwPSLf3MdGhkfPDlacEerqJuFZyTcUwf
         5vTF9iLPBbzjDAmO/dkGVQ3jcVe+HPj9oe539OQm+bbSI6ncevNEPC6YjLA7L9S1s50+
         UFWHHFzRu77qhtreHIPUDvLTcsEby1Zlpyf3OQuO4PGvz2b3UQKU3o7P583wWRXupWID
         V6M9W3VvVQdAhggJ5twzawiEhiPcPn4zRS6OdkzbBmuVWeEY7i4eMjAbFvUUVlY6qov0
         YPQlj5RkAx7cvwIHi1p0hNsKMNY8HTPaiE4eu+Fmqt+p++cZM6Su1kzB6yt3KI2IEwr6
         OpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975310; x=1794580110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xi81y1XZW609wk/sWs6sIq2iQGR+N/bC4UAGbPKuq4A=;
        b=Y7kgyWoJo74T6OQZLn+lVU3cBPrdVP+Z4j2z+vn/w869arI1/23yYzWocgx9KEmEXe
         Y9ARTlW3I8xBDQEw/bnrZvolloH2nEIhee1/MjXn8t100iXJb+Tco2N+xEorDZo6Pq4S
         i2zYqfah8lATCs+QHKgxzejF+2TgZ4hiIYUKPGnpRPWSHGEe34WnuKTZeWcNt2GW3SaW
         p0ruTyrrRu9BKPGUAEpvZyH0Z80HKjKBLZwWjwKv4OGNEeIV3jBYHa/O8iEaB3c1Sb7q
         wamB4JJpxgRcqWu4quRQWBThKFj1otyhmnsfwjMie71xxDgtB3cjPqIfcipyKfzGLYXM
         /lOA==
X-Gm-Message-State: APuU4Z+92IYw2cdxHkHhvvi/ELZU7arDEg6Xo85ym3BgDgK8bUykrCH5
	2WvmuWlbuENaGtlovDZRjrBkot3PpyNTGe0s10FH/Mtj0iZp/SELcb/D
X-Gm-Gg: AYBFou2S+7U5XgMjJqEuELu2bPYsso9VNBmZir3jCtwAVA9Y2FTWHbnbqwuxK4UQir2
	a4YBWZ3Vy0Zkf1TDKzQf36qIICDGmxQWZ5dz5e5VCvgTXB2Bs6yAafGOG+lHaEgIt8XkMhGyhn1
	LXtbNOc0O+B+EMFcqN2ptMRc+peVXChyVEhR0Brs9FKWx9BWOTBuVReV3EprhxIUIchZg8kdKQ0
	4q1phMRbZlzPVtU5uWA4qcU1rZbge+QLjHVkk2wG0JkqiX6olP7mTy0xZ3joTCkopfOhcjYVnlW
	yKyEcp1/jvTv7//Ta0ULK5y6O7mRzMoeLsoKhPpFmoZUQmipFzx/dCVSHUnd6ZhjMfUrIeT4wqL
	nw3eZ+ij+Rbwe87Z5Q0j058vJeq5YZZ8b0toCibFJ2jvedp7NWIxVzxd2ichiJZ/fkf3WCebZAf
	SUTnRMNFYYKxXxhEkHoYTnyVd0cTcwcjk2XVHU+3/J29T4ftVjjH5oKV9VxhllHVk3iS83g3aps
	cDUc9SpT6xGwJqCvklZI71nFaHgz13wC0x7aSKn1Hhy9Fvax2xNd8djk4Lw+fcAdXn9llurv0KP
	FSpxNyqj0eYuxMk0P3Z3gPqa8h5IwYa/Nh/OJKnfs4gIAlWbPXKX
X-Received: by 2002:a05:6a21:4ead:b0:3de:2fbc:c391 with SMTP id adf61e73a8af0-3eb9830cb5cmr4470055637.7.1793975309829;
        Fri, 06 Nov 2026 06:28:29 -0800 (PST)
Received: from DESKTOP-31QBR7C ([103.120.166.86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70aa6878sm634384a12.28.2026.11.06.06.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:28:29 -0800 (PST)
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Subject: [PATCH bpf-next] sched_ext: Reset task fields on exit of an SCX_TASK_READY task
Date: Fri,  6 Nov 2026 20:28:18 +0600
Message-ID: <20261106142818.1475-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a298fd5f4ee8 ("sched_ext: Fix use-after-free of a NONE rescuee
leaving its sched while running") moved the reset of SCX-managed fields
out of scx_disable_task() into scx_reset_task_fields() so that it can be
invoked on every path where a task leaves its scheduler's control,
including tasks in SCX_TASK_NONE.

However, in __scx_disable_and_exit_task(), an exiting task in state
SCX_TASK_READY (e.g., a forked task that was initialized via
ops.init_task() but never enabled under an ext_sched_class before exiting,
or a disabled task) currently breaks out of the state switch without
calling scx_reset_task_fields().

Consequently, its managed fields (vtime, slice, reenqueue flags, and
watchdog runnable_at reset) are not reset, violating the invariant that a
task leaving its scheduler's control starts clean.

Call scx_reset_task_fields() in the SCX_TASK_READY case of
__scx_disable_and_exit_task() to ensure consistent cleanup across all exit
paths.

Fixes: a298fd5f4ee8 ("sched_ext: Fix use-after-free of a NONE rescuee leaving its sched while running")
Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
---
 kernel/sched/ext/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f74ffb3b1aca..b57a7989f304 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4728,6 +4728,7 @@ void __scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
 		args.cancelled = true;
 		break;
 	case SCX_TASK_READY:
+		scx_reset_task_fields(task_rq(p), p);
 		break;
 	case SCX_TASK_ENABLED:
 		scx_disable_task(sch, p);
-- 
2.55.0.windows.3

