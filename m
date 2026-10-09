Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8049E5C4;
	Fri,  9 Oct 2026 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791539043; cv=none; b=c8ubcLEJgat3G9ucfTs9AGlnwIHzXO2K2N645ouNWgqSU8jL9EEMn5cR1Q0A1NdaaQ2hedmqU+sSKHVBi1YpKxWXox8kt2TDARuZIQXiYRqKKyIsca6HeHs02r8tB9XOyzlfGLFf4X7ExR+h6uGaqniatzDVIuLj547kKlDjZ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791539043; c=relaxed/simple;
	bh=3RHLBfOIIw/lfId3Cjz+wo55ycZqYQprtmJXyaZ8MIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeUdryvTkGZQr97ApwSHqbUe0VAsh3egKDMsqAZbC9l5EHsRDYu6hk2wYkb3T0DIMvDlU6GwHQUdxbO5sSbHpmfLgL6ADaaVA0qA9M56zsv4jxbXU5rViSLvUYJyJO9ntL4oOyd2iKISyqC9eGRnWiO1qftkp2sZkiwmK4dTP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHbnzD2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHbnzD2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B01E1F000FF;
	Fri,  9 Oct 2026 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791539037;
	bh=3RHLBfOIIw/lfId3Cjz+wo55ycZqYQprtmJXyaZ8MIs=;
	h=From:To:Cc:Subject:Date;
	b=IHbnzD2buhzhRt4cc4u5Wh/vEUFvi22SZ1gD4cH85aOECQikbAcl7/7JHDDt3wRju
	 99UBCtjtcgGvrmfiYGouoGmhUHz5ASJnTDCwywd0QptlX0ofzLe44WaT68IpJQ/SLF
	 l/frVZWGhR9TrjLDpHT+COf6XJRIzA+wrang0/6RywsCAy5+0pPn3mu/xijBdCsauJ
	 +e91pzEby/9XQoVOLSZWmHKW+imfSM7hGUJQ5p3YyBOcUzFjNOlYwjQuCN6f08LeAj
	 j/ZoZY35Ht6h3PDRd7Bakv8YVHRCkfEr/InUTDw6YX/jhscl12fjjoX1pqdO6NaXRm
	 pLNrb2+epA/nA==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.4] sched_ext: Report a sub-scheduler's attach-time ecaps before lifting its enable bypass
Date: Thu,  8 Oct 2026 23:43:54 -1000
Message-ID: <20261009094356.2852794-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

A sub-scheduler learns which cids it holds through ops.sub_ecaps_updated(),
but the grants its parent makes when it attaches are reported only after its
enable bypass is lifted, which is also when its tasks are handed to it. So
it gets its first ops.enqueue() calls before it has been notified of a
single cid and has to hold the tasks somewhere until the grants arrive.

Patch 1 factors the per-cpu ecaps sync out of the dispatch-side drain so
that it can run from elsewhere. Patch 2 has the enable path report the
attach-time grants on every cpu while the sub-scheduler is still bypassing,
so that it has its complete cid view when the first task arrives.

Verified with a sub-scheduler attaching under a parent with tasks already
queued, with cids revoked and granted back while attached, and across detach
and re-attach: no task is rescued or stalled at attach, and the root
scheduler is unaffected. The ordering between the enable path, the per-cpu
syncs and the parent's grants was model-checked with TLC.

Based on sched_ext/for-7.4 (3d7c2f550eef).

This patchset contains the following 2 patches.

 0001 sched_ext: Factor out sync_pcpu_ecaps()
 0002 sched_ext: Report a sub-scheduler's attach-time ecaps before lifting its enable bypass

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git sub-attach-ecaps

diffstat follows. Thanks.

 kernel/sched/ext/sub.c | 194 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 134 insertions(+), 60 deletions(-)

--
tejun
