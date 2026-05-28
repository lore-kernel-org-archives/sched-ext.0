Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C92765FF;
	Thu, 28 May 2026 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978428; cv=none; b=e9e3Pd/H3PgCPbqxOnWsH57JoFTimVOrHPeD4uMVCSwAzCGsSIinYq45CYFA0KhNoKb1V1ML/QgLebh12GSG7R1YjO+twtTFo5Tnk9sbWmIwmnTQjJvN1xI7bpa9coS+LGhxEYCxGio2cSFWHr90YHpSYMIK+SD9osTOsAvy/ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978428; c=relaxed/simple;
	bh=SSaQxosziNsXUX52izApzh68lWiy2puB9ecyH50HnsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPHfxbscs13xYfrdLEma/OdVVCsULkVKdVVuG+OHqFzg7s1cLBK4Me5l3hIgifa5emHQ/ejo4qNqbX9oDBWapnjRDj1/UN/QDIYPH/K/ShpEsX323X0Bvs/K/qLpdrc9AZeKBCUzf+QLA+WSHbd0QDEjtp8QOXQ3pyHZwhILECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMgxcPtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMgxcPtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0D71F00A3D;
	Thu, 28 May 2026 14:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978426;
	bh=v7AE5eNvFgCMuxasZr2jUz+r4yoi3G0+AJF3aOpebkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RMgxcPtnQCWL3OvW24XTJSByiYsxs7TA/cFjq+lK8eITonmGz7uMU3ZiRAGgmpOKi
	 2ri3oJeJU+GWE22tUI+76UEBnPSqtUp1hgMe2ZfuVdH3NBAR0gJ34bEyzDCnDA1pem
	 JiOP55I6XDX7jLkorW41QEqS4Nsue+XqLnL9pkigbolRJ7AtPvaql+wWE4sSY8OwbM
	 HYAsq38zcgkjramgtiqxkjSqrH0tvmEoEHpjoLoECZFA6EJ6MtOcCYCh7fS3bEz+8i
	 t2jyzQdYV3QrsPrkNxdQJUlmgcu/dYF7pi+r51WmCqQ/Pfg3DNd8DH/Z8vAYXy6r31
	 DdV+4Q64Y4QvQ==
Date: Thu, 28 May 2026 04:27:06 -1000
From: Tejun Heo <tj@kernel.org>
To: quzicheng315@gmail.com
Cc: peterz@infradead.org, arighi@nvidia.com, brho@google.com,
	bsegall@google.com, changwoo@igalia.com, dietmar.eggemann@arm.com,
	haoluo@google.com, joshdon@google.com, juri.lelli@redhat.co,
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, quzicheng@huawei.com,
	rostedt@goodmis.org, sched-ext@lists.linux.dev,
	tanghui20@huawei.com, vincent.guittot@linaro.org,
	void@manifault.com, vschneid@redhat.com, zhangqiao22@huawei.com
Subject: Re: [PATCH v3] sched/fair: Rebuild load weight when switching to fair
Message-ID: <ahhQumeje0bSBdrP@slm.duckdns.org>
References: <20260528092535.GC343181@noisy.programming.kicks-ass.net>
 <20260528131238.3879110-1-quzicheng315@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528131238.3879110-1-quzicheng315@gmail.com>

On Thu, May 28, 2026 at 09:12:38PM +0800, quzicheng315@gmail.com wrote:
> From: Zicheng Qu <quzicheng@huawei.com>
> 
> Tasks that run outside fair may not keep p->se.load in sync with their
> current scheduling policy and static priority. sched_ext, for example,
> uses p->scx.weight as the active scheduling weight, so p->se.load can be
> stale when a task moves back to fair.
> 
> The fair_sched_class expects the sched_entity load weight to be valid
> before the task is enqueued. Rebuild it from fair's switching_to hook,
> which runs after the class has been changed to fair and before enqueue,
> so both sched_ext disable and SCHED_EXT to SCHED_NORMAL transitions get
> a native fair load weight.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
