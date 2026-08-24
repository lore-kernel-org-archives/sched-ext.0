Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F3425B0AB
	for <sched-ext@lists.linux.dev>; Mon, 24 Aug 2026 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562923; cv=none; b=V3bgvXGvEGHIRi3DInsLQrpJ6iwSnjtGAKQwcrbaX9Oj5JN/FMpfUpUaMNH4QjSZmZaO03TBAydWw5a7G6Cvai5XVKTbMIGIGHGUidT+aB3Rnnk9f3ozNhERJEygYcEZfFGijwOTQsZj5xMBcvDC6/kaiCY49r5+l1CCAEleAWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562923; c=relaxed/simple;
	bh=/a3UdMAG3Wpio/vEfjbyWbIH9dXhD1uWGifnE5BbjaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l6o48b/iNFFFljR4fazq+A5hF3HaHdl9+dEEL6mTKGQcA/3r4A2SmG3OOgBv38eOaUPU/I2BHeoqJtsyTDYzEv07sqY3vhIEUj4+xXZZrgwRYQR1+QPtAq98ds2+sbMxBWvY78LwwvGVw2cnxo0xZcaOvZAn/NH1QmfNWQylGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YZk6CAnb; arc=none smtp.client-ip=95.215.58.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YZk6CAnb"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=/a3UdMAG3Wpio/vEfjbyWbIH9dXhD1uWGifnE5BbjaA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787562918; v=1; x=1788167718;
 b=YZk6CAnbaEfbQsuRpjoGheFJWk13NqQvFkrJVCdeYfw1SbrUOLcJOKFiELJiw71EkKfMsTqw
 2bIofuwpJUTfm9EOR9giDQEote5aRIaPCRytccLpL7lsKnCWAgGmf6MM9A58j+5fq4wcnsV+cwr
 ZBvK6G9hWnevBL52lc8oUC7c=
X-Envelope-To: sched-ext@lists.linux.dev
Received: from ctao-book.. (223.70.160.239)
	by smtp.migadu.com with ESMTPS id 9901acb9e34782cb;
	Mon, 24 Aug 2026 09:15:14 +0000
X-Mizu-Trace-ID: 9901acb9e34782cb
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
Subject: [PATCH v3] docs/sched_ext: document that cgroup CPU knobs are scheduler-dependent
Date: Mon, 24 Aug 2026 17:15:01 +0800
Message-ID: <20260824091501.547649-1-cui.tao@linux.dev>
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
and how a knob takes effect is up to the loaded scheduler: it may
implement the corresponding callback partially or not at all. The
same applies to other knobs like nice levels.

Document this in the basics section so users and container
orchestrators know what to expect from a BPF scheduler.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
v2 -> v3: Drop the scheduler list and the nr_throttled example, keep
the section concise and generic, per review.

v2: https://lore.kernel.org/r/20260819012157.220932-1-cui.tao@linux.dev

 Documentation/scheduler/sched-ext.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 35b550671ca7..b594d93dd6aa 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -242,6 +242,18 @@ optional. The following modified excerpt is from
             .name                   = "simple",
     };
 
+Scheduler-Dependent Knobs
+-------------------------
+
+The fair class enforces cpu controller knobs such as ``cpu.max``,
+``cpu.weight`` and ``cpu.idle`` in the kernel. sched_ext only passes
+them to the BPF scheduler through ``ops.cgroup_set_weight()``,
+``ops.cgroup_set_idle()``, ``ops.cgroup_set_bandwidth()`` and friends.
+Whether and how a knob takes effect is up to the loaded scheduler: it
+may implement the corresponding callback partially or not at all. The
+same applies to other knobs like nice levels. When relying on these
+knobs, check the documentation or source of the loaded scheduler.
+
 Dispatch Queues
 ---------------
 
-- 
2.43.0

