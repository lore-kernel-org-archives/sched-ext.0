Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471F37DAA9
	for <sched-ext@lists.linux.dev>; Thu,  8 Oct 2026 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430766; cv=none; b=shFogiwEB+72vGu6HtSzWGx7Ysh2MNe7Ju2f9/xBRWDL5vkq4Saci2vONXX7RP7VuoXO0aPeZ5RERuI/7i/Va9optM5RWccsDp+ig3StqCIDssXTHkZ3XRVB4TC8EWJH9znIieChvfEJkz5v5jcHGyD2iAZG8j9qzle63zTupXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430766; c=relaxed/simple;
	bh=y/ArmdcIN0oSMG/E817Czleq76IrcT3GDRfKm35t634=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=i/nhhtYFswdBt9vOdC84C0hVAddaC7i3ZoAADfxPa4wXcr3PAN4n6k5X6XRXxJKIPTrcbTuJ7F9bpcuMc1BzY6JKuabqYnq1qXDKQoGueZ06swJW2ipgt8ExmbmgmYH1WsJY6z075/olyMoBwPDp9eyhGFQjy1q5e1DGHvixBy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ej2bKRSg; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ej2bKRSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:From:To:Subject:Date; bh=y/ArmdcIN0oSMG/
	E817Czleq76IrcT3GDRfKm35t634=; b=Ej2bKRSgMGlwqq3bn7Uea/8k6QAggDj
	OpUwNwZodny+X7az1+JdFjFIKbEsEPkdaqZcvUNqOhbcTRONlZKecEsog6JD74Ok
	qqt4bgqheemOiSKMxfRP1MdJ41vPDGkj+D7HfYLrWMpfqi3OJ3aW8RiqiYAYIJqH
	yx58U0iW3tZQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAn3rwxEMdqsY6uDA--.23401S2;
	Thu, 08 Oct 2026 11:38:26 +0800 (CST)
Message-ID: <afd4a6b6edf916131a089068c1da84db.sh_def@163.com>
From: Hui Su <sh_def@163.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Hold DSQ refs for deferred reenqueues
Date: Thu, 08 Oct 2026 12:38:06 +0900
In-Reply-To: <ar0qLeKls0oBUEKO@gpd4>
References: <20260930143443.2862150-1-sh_def@163.com>
	<ar0qLeKls0oBUEKO@gpd4>
X-CM-TRANSID:_____wAn3rwxEMdqsY6uDA--.23401S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryfArWDur4xZF1fAry3CFg_yoW8uw1UpF
	WrXr1Ykrs5GrZ7trnrWw4UuFyS9ws3Ja1rGryrGr45uw1Ygw1IyrWxZr17WF4ayrs5Cw1U
	Zw1fuanrC3yqvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut3kNUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRKc+2rHEDLiEQAA3I
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi Andrea,

On Wed, Sep 30, 2026 at 17:26:37 +0200, Andrea Righi wrote:
> The race looks real, can you also share the test or the steps used to reproduce
> this? That would help validate the fix and assess the stable backport.

I originally observed a crash in this area on an unmodified kernel, but I
don't have a reliable natural reproducer for that schedule. To validate
the lifetime issue deterministically, I used a validation-only fixture to
force the window.

The pre-fix fixture pauses after process_deferred_reenq_users() detaches
the request, lets the DSQ be destroyed, and directly runs the reclaim
callback before the deferred path's final DSQ access. KASAN then reports
the UAF in run_deferred().

I ran it on 4-vCPU x86_64 KVM with CONFIG_KASAN_GENERIC=y and
CONFIG_SCHED_CLASS_EXT=y.

For v3, I used a separate active-cursor test. Reclamation stayed deferred
while the reenq_user() cursor was linked and completed after the cursor
was removed. KASAN and a separate PROVE_LOCKING/LOCKDEP run were clean.

> Sashiko's ordering concern looks like a false positive to me, at least on
> sched_ext/for-7.4, both this sequence and exit_dsq() list check are protected by
> deferred_reenq_lock.

> Can we avoid repeatedly queueing RCU callbacks while a detached reenqueue holds
> a reference?
>
> The callback leaves the base reference in place whenever a detached reenqueue is
> active, then starts another grace period just to check the count again. A long
> reenq_user() could make this repeat several times.
>
> Could the first callback instead drop the base reference, and have whichever
> side drops the final reference arrange the free? This would avoid polling
> through repeated RCU callbacks.

v3 follows Tejun's suggestion to avoid refcounts and leave the deferred
reenqueue hot path unchanged. The destruction-side sweep serializes with
deferred-list updates and checks whether a cursor remains. A callback may
still be retried while an active cursor remains, but that retry is
confined to DSQ destruction.

v3:
https://lore.kernel.org/lkml/20261008024753.4096008-1-sh_def@163.com/

Thanks,
Hui

