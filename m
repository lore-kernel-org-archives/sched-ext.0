Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04DC4F3EA0;
	Thu,  8 Oct 2026 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483799; cv=none; b=Kjn+RwsVHiIBPuqLGx3MEfEG+h1652mmrxYpvlgb2URvIvL8Ky34gRskDRpJArF0j3SLx8hDmYZBeeNWb35/p3a/1Pq0oLFjn3tNCtW0CxVWAdWfPakKFYNJ+bljeSH995u70WEALOTVvSsxzkI9Clzw2M34EsryMBXwak6NQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483799; c=relaxed/simple;
	bh=GQExrJkM2tYgTWqNNdoHLqt1rY7QLtXbDygcwgBd8G4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=TaX0Cbnyhs9TrxEo9nGFupniO+14cU8Xe3mnVpWKhCMqR64Cj/sDgjFlYmI+Mmnbor+o3FUnT+BqqayfCy+Xd0aDteITgGYYJ/IyUoP4e1Byazxw/1j1AFQaVpbQoUvp0A3rJJDoY+Srkrc0WZUBDdimF8wN1ftR1NgASOBoUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMwZOEhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMwZOEhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6E41F000FF;
	Thu,  8 Oct 2026 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791483797;
	bh=EvRgs+cpndc9p8a2bte1OWIf5p1C7+/tNT7CHOVs22U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RMwZOEhc+pk8bQwz7u108dqPGj1cWOYubkfRXGyM2KLOwlqEhPJgMIzY67SnZV60I
	 xMAkey1dE1gkSDDaNu1cMsxWDmPCW0j9T7Q60dtSDkU0u5LbtOjo7Ps2U76bBVwIT/
	 7fsSCm/S2AsMYZlNPjcKP0uKAb3wTR53xUGSBk1f8d7kHuRo53AIyi0psU9zYLCRbn
	 OyXMfN3XhqKp0Xy4cNnTcHznSoIX1N2OHSOnUW3sbGVwHd2YD5SK7VXF44EY+z8P40
	 ZrExCb1XbGXGKcOe0+buOhi3T8G7L2cIGtq+ofRaY07/rQpHQAUjc0pOzIw+eIrL8W
	 vXy2+UvmBgd+w==
Date: Thu, 08 Oct 2026 08:23:16 -1000
Message-ID: <61b9a8607e1f25ffd316f13135432581@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Vladimir Vdovin <deliran@verdict.gg>, Emil Tsalapatis <etsal@meta.com>, Christian Loehle <christian.loehle@arm.com>, Balbir Singh <balbirs@nvidia.com>, Lee Trager <ltrager@nvidia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.4] sched_ext: Add NUMA balancing support
In-Reply-To: <20261004072901.3579967-1-arighi@nvidia.com>
References: <20261004072901.3579967-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sun, Oct 04, 2026 at 09:27:06AM +0200, Andrea Righi wrote:
> This series lets a BPF scheduler opt into the NUMA hinting-fault scan with
> SCX_OPS_NUMA_BALANCING. The existing scan is driven from the sched_ext tick for
> the tasks of such a scheduler, and the hinting faults then work for them as they
> do for fair tasks: the kernel maintains their NUMA fault statistics and
> preferred node, and migrates the memory a task accesses toward the node it runs
> on. The tasks themselves are not migrated: their placement is left to the BPF
> scheduler.
>
> The resulting preferred node is exposed to BPF schedulers with
> scx_bpf_task_numa_nid(), which they can use to keep a task close to its memory
> when placing or balancing it. The value is advisory; nothing in the kernel acts
> on it for these tasks.

Is there a reason to gate this on a separate ops flag? An alternative would be
an op which is called when a task's preferred node changes, with the initial
node reported on enable like ops.set_weight(), and enabling the hinting-fault
scan iff the op is implemented. The scheduler then gets an event it can act on
rather than a value to poll. The node has a single writer, sched_setnuma(),
which already dequeues and re-enqueues the task under the rq lock, so the op
can be called from there the same way ops.set_weight() is called from the
reweight path.

Thanks.

-- 
tejun
