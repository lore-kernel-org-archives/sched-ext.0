Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23749EC69
	for <sched-ext@lists.linux.dev>; Tue,  8 Sep 2026 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875270; cv=none; b=JgK54omqaP8Kn0MAnxnDQVFmRti5cUU7VsHot5Vc7PSUYUUHAR/vCZEQwnHTzCxjxQM80qYiOG0pkEOdiRN08sF1wznl/lMI7CEOWE8jj68b8tVZzC+E56iLALNKCrJ/rk6B+UdRKAZPd5+wobkGHVzVg8An4oSjdrPhH9bq7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875270; c=relaxed/simple;
	bh=oduoZK+jENrZgBXIkCWyfii21NlUokwD06N+XhSLNXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANFOWSwK+/Sna8nP/tFENtw1FJVMd9D+wA/3+iV8i3g5rlrLgO9/V0yjA8iyKf8TNAVbA5ikN4dksqIhL4Avys2YRTiadTPc/CxB7J6rAri7u4ASuHYQvqg3gYTFGOOTeonAl+2Djd2C6r9GJrntqdDAgxehqD7b0zbat0OH1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrYWLW0P; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrYWLW0P"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398e9698a70so4098081a91.0
        for <sched-ext@lists.linux.dev>; Tue, 08 Sep 2026 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875259; x=1789480059; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L+7FkH0SClwIFT6tbK6YLAo1eabVFn+niXZ/SWTrNV0=;
        b=hrYWLW0PxW8a0qqOGOH4W8VZPLXLejvRC0uUyLrfinZjn/2Wh8S6I0wGm+7U//CIjH
         rlBnVNBDD19QDq1pmpFgzZIGJQ6eacGEYMYnPRgrhkRIdAIoBeELmIH7+cIaLGPeKw9b
         e2Jpt9nKe3MQg+IBPARUY7QbmGkEkUkMb7iab1d6owRI6J7JNLecaWla4NGeIfHrA6Zo
         B/P86J19LFH24aSTdTyDVI6Uz15rXe7UXrNDtgIuCGH0KnuKV5VPaMXxYNOK2AVfWz5L
         TKvBrFXvxMp7PbI6hV6+JOV6n7SwBPh2Ops5gDpdWhchLBiPiIyE0YCkyUG2SlqgiVH6
         LooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875259; x=1789480059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L+7FkH0SClwIFT6tbK6YLAo1eabVFn+niXZ/SWTrNV0=;
        b=KQJ+2edGhym0MFeTLRtpQ6b07sym9SXNKU1n6Lp7bGm+HmDKOGuA3AFQuVCNCLoBXx
         Ea78FJWauG86bwuMpBT04U6Na3VA/r1zzzVPFDVdoAsJIMqnMRHt2aMw3tr9eiSvTZ55
         pvqzg1nwdT596fU+v+NKXiGV+ivmVC2+cfoCRpPQ636B5dgNRn2QoORzIiQKohu6hSyJ
         72+dQ7l/MoYHzwTspwdfT/Y0rolAasLhg3x8WtvkfbLrbHOvkrwn4X5sLQd9fz2683z4
         XkrQDAVdJ6VmGyLZZlhWDUibo/DhL3oxEZYMLXIV9ASekXiRvAYNKQEUdkRhKicoSKMR
         wg/w==
X-Gm-Message-State: AFuF++mXoYPRu5FCogO7PLv54vYphsBr30mgNHjSF2w11KEJxpgMOM63
	sDHCJWfeQieIiNvBJI1s1BByz0KVK1o1dYYMtbtwuDstx4hNoZImlcPnsoXQTg==
X-Gm-Gg: AYBFou2U7aQtbWo+OZ7zX5rzlQH0QP58WpkSIEp4JFj4KG01XnY3m+x1zuO+9x2APmE
	hNv3fUD9kMeTRJfmtIyaCy0wxr5uUcGdg9lD30KLleR8LjNeE2C5xCpZmm4ljqRjwqKcL+JDniB
	z9sL6Bin8vixa/2VfsvOOTlYKmeppQMvPVH/FAVHk1oouGWFYKSOVSLhubxCOpNVw4uQbjaJkh3
	qCUolTdsyBYDX7phCoxyR9b9auuVXylObsyXuAU58DFEC9pqEfj+FqdSO8uVY1F54oWm5OmVU2t
	zYXJuxQ3PPXdvu0t+7pXxo/ZmZz86t0WfLUt4+TccoptSsjGhi8P345adYrr3MJ8YVWxzZ1omAs
	ehdqJ2BUbp5ZVIEKcL6PNuPEqOmcQ/YiJnnsRzhQuT8KI0LfStRfpNPiSabv4bpQ672H1iWkbbS
	eetCwUyeHtOJtUxbg203YhQCuubcLPBSNMnl2p5mPlUf8eZgUnZZaAewmU2plqjKUQNIsN69lk7
	Q9/ytk3UmaY+TKa9f4+wuVuhok+o3TWwW3HQDwKBSIqlWjnzriYf3fT0G/vJX+HKRA0geA=
X-Received: by 2002:a17:90b:1b05:b0:398:9bd1:3210 with SMTP id 98e67ed59e1d1-39b262a89d4mr39830682a91.17.1788875259007;
        Tue, 08 Sep 2026 06:47:39 -0700 (PDT)
Received: from cchengyang.duckdns.org (1-164-68-170.dynamic-ip.hinet.net. [1.164.68.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae610e5b2sm9994013a91.0.2026.09.08.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:47:38 -0700 (PDT)
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
Subject: [PATCH 1/2] tools/sched_ext: Drop the no-op -rdynamic from CFLAGS
Date: Tue,  8 Sep 2026 21:47:08 +0800
Message-ID: <20260908134722.8671-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908134722.8671-1-yphbchou0911@gmail.com>
References: <20260908134722.8671-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because CFLAGS only applies to compilation ($(CC) -c), the link-time
flag -rdynamic is inert during the build. Schedulers do not rely on
exported dynamic symbols, and binaries remain byte-identical without it.

Under -Werror, Clang treats this unused argument as a build error:

	$ make CC=clang-21
	clang-21: error: argument unused during compilation: '-rdynamic'
					 [-Werror,-Wunused-command-line-argument]

Drop -rdynamic from CFLAGS to ensure clean builds across Clang versions.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 21554f0896923..70d2503b6b330 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -89,7 +89,7 @@ ifneq ($(wildcard $(GENHDR)),)
   GENFLAGS := -DHAVE_GENHDR
 endif
 
-CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
+CFLAGS += -g -O2 -pthread -Wall -Werror $(GENFLAGS)				\
 	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
 	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(CURDIR)/include
 
-- 
2.43.0

