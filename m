Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445544;
	b=20mbJzWP6b+aRFXRRDKDtqKxFn0zG6rNf9OJ4MA4hqQjVtR0Qk6LtKqBrhfHCwVhXVrR
	 K+yf7TVGc6BD1P0QlGwD5hYb60nH2XAsffl0COOihIlp5z/qzRU4pgvusVccS/C8LT3u1
	 84TDXSAkTzw9f7vGtOaphxYYexCw9CB35u6PX4ZB9XCcvPkck5XrlQo+tyRCzfDf4S4Lz
	 k2R/FIl7OmbdUUpbhtvISrBoNJrecXKLjchzNQpC7wnSDy5/y6rGQMvgVYje3TXMdL/7J
	 MJkaJC4Gneo/S7GWZhlZSf8XSEZaBoEXcuwhwOIyQVhzcM+II/W9XmTXqTjf3rwpWIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cRi93T+jNYVirUzUSXcTORRFIMOIJBsGzIUrnsz2YcA=;
	b=oqpwY5jRrF1MxiaqmPVmtSMicvBbM8bvsQijcX3zAMaLltNIsHRcjhvdUhJSqxXYBwiU
	 YQ7rCMiuQw0I0hGMXhqoJ8RTfn5cKJm1nNc4828UrdjeSOclaOPknM28+XbD5l6i0JQw7
	 6CdSZwcS0Gu3YXy7div+m1uxFfa8Gf7RIOMm7tUyO8zgBjwKhWGbCiLlQLlwBHeggHkZ+
	 Hla3jR/b2mYMe2JAltlp2Zaf0YB5k6jovVaOd6Q/hOgMXulrbaTMBhbrEDL1C20E0cLu5
	 CNdnzXdiBmMHvxcHzWQazlptJn4AQ4OoVoXyvVW5lsRabEFr3uNuCtb5Y2MOV0Gsp9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO6SdweY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592EB606A31C;
	Mon, 19 Oct 2026 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO6SdweY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BF01F000C4;
	Mon, 19 Oct 2026 21:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445543;
	bh=cRi93T+jNYVirUzUSXcTORRFIMOIJBsGzIUrnsz2YcA=;
	h=From:To:Cc:Subject:Date;
	b=ZO6SdweYfLmdFfj8H42zkR+c1UlKibf8J8OtzU4XGMr/NTQLtkDm1SOihFu6HBdgU
	 pYkOTxbW7GvHmTjyjZ0LH/T0BUCoGBqywF76v78SjDjeHmtjkJ9QnqRaQwlZxTxFQd
	 XTaoFUNW5ODsAceAhK1bbzHCXEOM+RAThlEbJwdjz3nXVVO5HZ3U8MiltcVV80gB+c
	 m/iF94ajoMonMb3NzQVKLZSipn40XRWhOD5+/U3eOcgwE2397ydu6yDLYk2UUOFJhC
	 YnW64SauZ6a9kBRFAu5YS+Kwv+8gng5TTuPCY7+LaBYoKwpX7kWWYiglIcKSnVTU0g
	 TvT5keA3uraog==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.5] sched_ext: scx_qmap: Drop the compat code and fix a lowpri starvation
Date: Mon, 19 Oct 2026 11:32:19 -1000
Message-ID: <20261019213221.2919481-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
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

Hello,

scx_qmap is often used to exercise sched_ext features as they land and
already requires the kernel it ships with, so its compat code only keeps
untested fallbacks around. The first patch drops it.

The second fixes scx_qmap's lowpri path. Nice 19 tasks coming back from
LOWPRI_DSQ go to SHARED_DSQ, which is consumed ahead of the FIFOs, so enough
nice 19 CPU hogs starve every other task until the watchdog ejects the
scheduler. They now go to their FIFO instead.

Tested with root and sub-scheduler instances under nice 0 and nice 19 CPU
hogs. Without the fix, the root is ejected within seconds. With it, the runs
complete and the FIFOs keep being dispatched.

Based on sched_ext/for-7.4-fixes (ff343a94e44d).

This patchset contains the following 2 patches.

 0001 sched_ext: scx_qmap: Drop the compat code
 0002 sched_ext: scx_qmap: Queue re-enqueued lowpri tasks on their FIFO

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git qmap-nocompat

diffstat follows. Thanks.

 tools/sched_ext/scx_qmap.bpf.c | 40 +++++++++++++++++++++++-----------------
 tools/sched_ext/scx_qmap.c     | 14 +++++---------
 2 files changed, 28 insertions(+), 26 deletions(-)

--
tejun
