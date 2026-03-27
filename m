Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FBE20010C
	for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605098; cv=none; b=B5202TR+pXO2BQfih1t9DUbbvuTVRYTHP21fn+VLgw+cuXtaZW90eFN+J8G+yAwZqSJx5Tb2kU5+XTtfxyNg/w0Pxmc/b7RfrNZ2HhVEO0xbWA3ToIhniKIv+8RxoQXd9SkjocWMbouanu0E/6Ab/WP7T+TbdGcReZA4AfPkij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605098; c=relaxed/simple;
	bh=riqm/5BR5EME9jYTD4WRT0/3N6nXSLaZh9DKkm0AaS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qOAQi5HlL7yCJX3cDDQwhDfXUMMbCm15kJHJFxtY9ncp8PwBzUqIaXo0By15mDQ8+VA/DMu8j3PLVxZqaZJ6p/D2H6BqJsRWmOF3/u6FGCXOuyZNMphKH0mZKWvts6dFb40CzXbxxrCbqGSMCq3h8qTDdQppk2hkZxu+lFEslhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pcqkmyIi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcqkmyIi"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so1750100a91.0
        for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774605096; x=1775209896; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwKsnrciPNrPR8CREqGVpci1fH+U1IgtKpv1DVqKV90=;
        b=pcqkmyIiP5HTT+cBOihgr4PG3PXuV5yL6kaae4GC6fQ+mYzvuRpHHiOKZ+E1TkN43b
         y0U6wm58Ivu2FpyMEYFVI0AxxyunKjJIeBYmhLesDhL1pi8ira5mT3Ylks/B51E9hO/2
         LKnu6QHaPg2p5zbAljoaTRUJPkWtnMzfS3IegrRN3dAkKwuG8aORh7rzte6ibakrLXUk
         +C8ohqwQZgdQpvn2cgHlQTpz2S/ImvYwaXyKP3O8MBbBESKz9vGDVDbqp7+2wfCW+xAC
         kplVx60xnRYlXy6q1cFAsxzIzVaf2qjtJPuXHjQfBG4i97lp8JbWx69dnxMbAHtIzk+l
         qpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774605096; x=1775209896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwKsnrciPNrPR8CREqGVpci1fH+U1IgtKpv1DVqKV90=;
        b=ZvBtqTfut1qF+qURCdBv/rj70Lpu5Va/T1/k+1jrjMvgNnUMkZM2ms28u7Un6wYEPy
         s4E8OmseIOORCBHkCRUAcGInriiXAbOgEAKCuvecQfSn3ZtWe+A1tfqvCAB15OLBLWbI
         ebzCEbIlMyiHsXcDZE4VOYtc9mDkWH40rW5VrYLTjyYnaTT49pu2/C1jvUDWwak/wELJ
         9z4nABFwvbLR51n5hQZI7abgKJrfEOTrlMeq28pf9E78EkjIW4NP9i4b/fDmZDIpzzb3
         MRhEWF0E+r7jt9+KT0PCONKLiLP+QNFSrpw1p/jsQL9HfuhgvKLFgg/iSs4rhYIFr8zY
         /QDQ==
X-Gm-Message-State: AOJu0Yxq2qAW+EAR+gFYyDaYLTpFwWvsmbhi8jYB1gCuO7AQ20LecdPD
	XpAmdTOje1R22wo8pDbCIRETZLt8IhG1uBYDC7CVwItgUzy5YgkgtnVmbkQiU0R/
X-Gm-Gg: ATEYQzwQsEsUUUOWWSzZo9pe0K+XB+IZ0ejNmYYY0O2Qt58UNLgLmnItgw4xypiVN16
	XI2TSqsh6PDkV+5hfVUapQ+iUfuQp9PDSlFofP5B7+cg7jfooPcn2mXu2TRvhBHPsAg9dgowAZW
	MmtNH6O8/HUWZJS53D8AgVLYPXgF0T3JBUTlwBUnWT/1ocVrOpHIRFEvi6yAbP/sa2rHRYNxpGL
	edM8Vq6HqT+9rY70g1Yw2+IUWd67SKev81BMRU1A5y+LFtP2HrJOSTVGNnfpvnVfdgahofmHuSB
	T6jU4S07ukT4iR8b8WAm1JUud5HSg0+WVmf7vaXmuMArdsT+YpB/hzzuH6PsBF0jq0Bt103To47
	iHv6WOjmUsvpwyQokkrgy6qq19wR3y+Soy3N12ReIUME85U83lgV/3na+NFIzmCUsTwiy5B5uUF
	cXVfTm4N+Hf1zzcw8xh0vmi/H+746J+Fc229fp3G7lhDQNPdLEF1+S
X-Received: by 2002:a17:902:e883:b0:2b0:62df:8532 with SMTP id d9443c01a7336-2b0cdd1aea9mr22493425ad.49.1774605095890;
        Fri, 27 Mar 2026 02:51:35 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:af69:9e67:ef33:2eb2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc68914bsm58766325ad.0.2026.03.27.02.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:51:35 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2] sched_ext: Document why built-in DSQs are unsupported sources in scx_bpf_dsq_move_to_local()
Date: Fri, 27 Mar 2026 17:50:39 +0800
Message-ID: <20260327095125.1149375-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a comment explaining the design intent behind rejecting built-in DSQs
(%SCX_DSQ_GLOBAL and %SCX_DSQ_LOCAL*) as sources. Local DSQs support
reenqueueing but the BPF scheduler cannot directly iterate or move tasks
from them. %SCX_DSQ_GLOBAL is similar but also doesn't support
reenqueueing because it maps to multiple per-node DSQs, making the scope
difficult to define.

Also annotate @dsq_id to make clear it must be a user-created DSQ.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
Changes in v2:
- Add comment to clarify why built-in DSQs are not supported as sources
  (Tejun Heo)
- Link to v1:
  https://lore.kernel.org/r/20260326091756.816828-1-yphbchou0911@gmail.com/

 kernel/sched/ext.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7043fb941130..bfe923b7ffe0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8212,7 +8212,7 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
 
 /**
  * scx_bpf_dsq_move_to_local - move a task from a DSQ to the current CPU's local DSQ
- * @dsq_id: DSQ to move task from
+ * @dsq_id: DSQ to move task from. Must be a user-created DSQ
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  * @enq_flags: %SCX_ENQ_*
  *
@@ -8220,6 +8220,14 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
  * local DSQ for execution with @enq_flags applied. Can only be called from
  * ops.dispatch().
  *
+ * Built-in DSQs (%SCX_DSQ_GLOBAL and %SCX_DSQ_LOCAL*) are not supported as
+ * sources. Local DSQs support reenqueueing (a task can be picked up for
+ * execution, dequeued for property changes, or reenqueued), but the BPF
+ * scheduler cannot directly iterate or move tasks from them. %SCX_DSQ_GLOBAL
+ * is similar but also doesn't support reenqueueing, as it maps to multiple
+ * per-node DSQs making the scope difficult to define; this may change in the
+ * future.
+ *
  * This function flushes the in-flight dispatches from scx_bpf_dsq_insert()
  * before trying to move from the specified DSQ. It may also grab rq locks and
  * thus can't be called under any BPF locks.
-- 
2.48.1

