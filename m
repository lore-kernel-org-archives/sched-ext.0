Received: from mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56113431E51
	for <sched-ext@lists.linux.dev>; Tue,  1 Sep 2026 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230471; cv=none; b=baTFBUHGf0iC03ywstO/WdPrDc0xfT310+4DT8ZfLwc9slxWMoTtoskdjzykDECkkwO7D0X/wYjYBmELPATtKud8bF35VWLPALio4aNdP9lNMJO2IqBos2mdokffSIx4H64YlfsHy0LPCrPb5jGAOXqSQR2qUGKy4dHg5CcD+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230471; c=relaxed/simple;
	bh=uaa47HjIg5FFqjOeEzANpXLJA0/CX5ySz08yr8qyvWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnlJ//UjJdzi6RPrBWf+phUIZjninjYi2Z6rFxL6+VF1ZgHcAIRLKTnDOrZAaR9AJlKth69yhEHaAtWFM46hBYyRz07HGRfIWRFOs7LMOQBmPjHXUxt5olVY7z8o8GU4fsMj0bwnxBMdAC52fkL0EKmXxpgbFx3xxc85mz/FKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YpszCp0E; arc=none smtp.client-ip=95.215.58.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YpszCp0E"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=uaa47HjIg5FFqjOeEzANpXLJA0/CX5ySz08yr8qyvWs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788230461; v=1; x=1788835261;
 b=YpszCp0EjHmKw35HUzq3ub8Vw0vSTPbCSNmC3taTLlaGuRf2/C4Ee7QwmpIXy/XS+l1TJMHU
 1vKLu/e+Zhh+L4AA7gGkcx9qWA+gUD1myXtt08j7bXo6I+08f4BwE4j8mzI+SpoANbjLCDVo4FC
 PkdB/mjTcQCfAD7niCBtrR78=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id b6cebc90bc5a86e6;
	Tue, 01 Sep 2026 02:40:50 +0000
X-Mizu-Trace-ID: b6cebc90bc5a86e6
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	michalblk@google.com,
	liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/2] sched_ext: fix wraparound-unsafe vtime orderings
Date: Tue,  1 Sep 2026 10:40:36 +0800
Message-ID: <20260901024038.730424-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Two spots order tasks by 64-bit virtual time with comparisons that
break when the values are far apart: the kernel's vtime DSQ priority
queue and scx_flatcg's cgroup tree. They need opposite fixes, which
is the point of this series.

The kernel's scx_dsq_priq_less() compares with time_before64(), i.e.
(s64)(a - b) < 0. That is only a valid ordering when all values in
the queue are less than 2^63 apart. CFS upholds that invariant with
min_vruntime clamping; sched_ext cannot, because dsq_vtime comes
straight from the BPF scheduler. A scheduler that inserts vtimes
wider than 2^63 apart into one DSQ gets the inverted order -- the
tasks it placed last run first while the rest starve. Patch 1
switches to a plain u64 comparison, which is a total order and always
honors the requested order; it reproduces the inversion with a probe
scheduler and verifies the fix.

scx_flatcg's cgv_node_less() has the inverse problem: it compares
with a plain <, which misorders once cvtime wraps. There the cyclic
(s64)(a - b) < 0 comparison from patch 1's bug is the correct fix,
because flatcg does uphold the spread invariant --
cgrp_cap_budget() clamps every node to within max_budget behind
cvtime_now -- and the cyclic comparison also carries the ordering
correctly across the natural 2^64 wrap, which a plain comparison
would not.

So: same bug family, opposite fixes, each justified by whether the
spread invariant exists. This is also why the naive "use
time_before64 everywhere" suggestion doesn't hold -- without the
invariant it is exactly the inversion patch 1 fixes.

Tao Cui (2):
  sched_ext: fix vtime priority queue inversion on wide vtime spread
  sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe

 kernel/sched/ext/ext.c           | 3 ++-
 tools/sched_ext/scx_flatcg.bpf.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.43.0

