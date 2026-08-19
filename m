Received: from mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F93932E1
	for <sched-ext@lists.linux.dev>; Wed, 19 Aug 2026 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787102537; cv=none; b=Asu6XfLVNDyYLJYwzTp3Us+e8Uvo+NLJmcaC6YEG6vTRYBELDWh2YpwNAu6ciAQL5ARn1CAXNOiBm0FoyOdwbBARI1AKE5J8r/+/uovVYw1bap1T53Q0DhkmKNB5wW3S7U3mlKDLUSKX4HiPYwbrE9EKnr6xZuKMgt/BUA2XY5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787102537; c=relaxed/simple;
	bh=LW5oz5A7LnBblxcZER63gc3Wl37mjgopfABerrOaDJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXrripjbLKmllXfZ/4glgADyULia/Tm2cZOmG9nA1ZWFLb9LuNhfM1afFLEoi8iSQbJT1ndEgI7xkiSxf6iePFoB+3E4iH7q6PdaPZetOs/3seo7zvPKYdf9a1nLR6OnckT/NuwvanAE6B8W/bPy8kz2/Q99tCB/c18aVb470hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YxA++Afh; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YxA++Afh"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=LW5oz5A7LnBblxcZER63gc3Wl37mjgopfABerrOaDJA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787102531; v=1; x=1787707331;
 b=YxA++AfhJs6H0Ie26agIZ4uK++fXi2gUeEziLYZnXSSl4hw2R7qBZrhWjMm1HGbATUdo8Vmn
 KcaNcDmJMBaY0z+9gbLxtuk6pH2NK3F0Ul83/booSlqkMcVDwUd3Y7ELEm0IqXiSQ6fK7bUAi5z
 IrYYJJYU8ch6A9jCWvdRWe2I=
X-Envelope-To: sched-ext@lists.linux.dev
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 71d2ed90ecf43179;
	Wed, 19 Aug 2026 01:22:11 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2] docs/sched_ext: document that cgroup CPU knobs are scheduler-dependent
Date: Wed, 19 Aug 2026 09:21:57 +0800
Message-ID: <20260819012157.220932-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The fair class enforces cpu controller knobs such as cpu.max,
cpu.weight and cpu.idle in the kernel. sched_ext only passes them to
the BPF scheduler through the ops.cgroup_set_*() callbacks. Whether
and how a knob takes effect is up to the loaded scheduler: if it
doesn't implement the corresponding callback, the knob is ignored.
For example, none of scx_simple, scx_flatcg and scx_central implements
ops.cgroup_set_bandwidth(), so with them cpu.max has no effect -- the
cgroup runs at unlimited CPU with nr_throttled staying at 0.

The same applies to other knobs like nice levels.

Document this in the basics section so users and container
orchestrators know what to expect from a BPF scheduler.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
RFC -> v2: v1 added a pr_warn_once() for the missing
ops.cgroup_set_bandwidth() implementation. Drop the warning and
document the scheduler-dependent behavior in sched-ext.rst instead,
as suggested in review.

v1: https://lore.kernel.org/r/20260818135328.174152-1-cui.tao@linux.dev

 Documentation/scheduler/sched-ext.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 0e97fd019994..b742af4d3127 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -242,6 +242,24 @@ optional. The following modified excerpt is from
             .name                   = "simple",
     };
 
+Scheduler-Dependent Knobs
+-------------------------
+
+The fair class enforces cpu controller knobs such as ``cpu.max``,
+``cpu.weight`` and ``cpu.idle`` in the kernel. sched_ext only passes
+them to the BPF scheduler through ``ops.cgroup_set_weight()``,
+``ops.cgroup_set_idle()``, ``ops.cgroup_set_bandwidth()`` and friends.
+Whether and how a knob takes effect is up to the loaded scheduler: if
+it doesn't implement the corresponding callback, the knob is ignored.
+For example, none of scx_simple, scx_flatcg and scx_central implements
+``ops.cgroup_set_bandwidth()``, so with them ``cpu.max`` has no effect
+-- the cgroup runs at unlimited CPU with ``nr_throttled`` staying
+at 0.
+
+The same applies to other knobs like nice levels: the scheduler may
+honor them partially or not at all. When relying on these knobs, check
+the documentation or source of the loaded scheduler.
+
 Dispatch Queues
 ---------------
 
-- 
2.43.0

