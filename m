Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E215464D
	for <sched-ext@lists.linux.dev>; Sat, 11 Jul 2026 00:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783728276; cv=none; b=OUH02g/T75cPNC6p9CZ5lxnIFvGMzgbufIvcn3HbqCdgnK0wIfJufFPOJMxknUWP3FrqrgNGSEIGPr643Ira2dZZyGw4TxBGIlXZiSjONr6JMxdHX3Xvkl0JJugj5jn2Aq2OPAngEJLnUYJ5VjuJNeU3uk32UvCUnR3sT+otYeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783728276; c=relaxed/simple;
	bh=CtzAvAETEAgzJsS9KDxSbQQzWqqxtvsLYaHDaMQqydM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XkReOf86gDD2W96NSc7EhnMRiXRRXMysAPoLgPtugjCD8WIM7S9tHH51DeMMXA1NFnt3uNs6YzEjHrhbhJgdI7zjZlo9JpKWFo0EqQ/8GTq+qugI6bsQwhNqisroqQAF1EdcRq15jAKkJkpFWDoUMVC95HuatcrGG5CTopBVCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuRkR6Cb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuRkR6Cb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C4A1F000E9;
	Sat, 11 Jul 2026 00:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783728275;
	bh=qwC1qWpv2aFwxJ+HBQiK5igixMxJor73I0X50t85ZGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XuRkR6CbeicGA3eklrVksIEuq2mthhUvrE0f6tIPRlbXzPmxwiVUkKNJg0+OiCgoq
	 f+wY3ULGUlQe1z9wJPd9LHyBnHNQnx26u3sHNeaLMRRdwZUYt03yGe+89DMI9bTeaP
	 JPN/kiL8Q0h1qwGAnvC7+dOdy1Aq9a1sr72g1RFva8annvJpYcCpqJDJRg42ij1OOU
	 MaV54/k45zf3NMEiLmOErbXrYK6ur7KjQrvNarQJudP4lDu/M/okshol5IgLd1lhqU
	 A5DSlDAhUu7bYRKbXfVDocme/hAeyKK+2ZPCKWSIkPUW+QX1V6C5BmATBcwC9cQ3PM
	 /SZwUil3GGCjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH cgroup/for-7.2-fixes] cgroup: Create the psimon kthread
 outside of cgroup_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: tj@kernel.org, mkoutny@suse.com, sched-ext@lists.linux.dev, hannes@cmpxchg.org
In-Reply-To: <20260710134945-psimon-fix-tj@kernel.org>
References: <20260710100441.2653477-1-matt@readmodwrite.com>
 <20260710134945-psimon-fix-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 00:04:33 +0000
Message-Id: <20260711000434.36C4A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the psi rtpoll_t=
imer can be re-armed after it is deleted and subsequently execute after the=
 psi_group is freed, causing a Use-After-Free.
--

--- Patch [1]: [PATCH cgroup/for-7.2-fixes] cgroup: Create the psimon kthre=
ad outside of cgroup_mutex ---
commit 8790bcf0b23cb2132be9400b975c7f18fd1147b7
Author: Tejun Heo <tj@kernel.org>

cgroup: Create the psimon kthread outside of cgroup_mutex

This commit splits the trigger creation process so the rtpoll worker thread
is forked without holding cgroup_mutex. This resolves a deadlock between
cgroup_mutex and the fork path during sched_ext enablement.

Link: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readmodwrit=
e.com/

> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 848955f8893dd..b9f207c920edb 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c

[ ... ]

> @@ -1565,12 +1592,22 @@ static ssize_t psi_write(struct file *file, const=
 char __user *user_buf,
>  		return -EBUSY;
>  	}
> =20
> -	new =3D psi_trigger_create(&psi_system, buf, res, file, NULL);
> +	new =3D psi_trigger_create(&psi_system, buf, res, file, NULL,
> +				 &need_rtpoll_worker);
>  	if (IS_ERR(new)) {
>  		mutex_unlock(&seq->lock);
>  		return PTR_ERR(new);
>  	}
> =20
> +	if (need_rtpoll_worker) {
> +		ret =3D psi_trigger_create_rtpoll_worker(&psi_system);
> +		if (ret) {
> +			psi_trigger_destroy(new);

[Severity: High]
This isn't a bug introduced by this patch, but can the psi rtpoll_timer be
re-armed after it is deleted and subsequently execute after the psi_group is
freed, causing a use-after-free?

In psi_trigger_destroy(), the timer is deleted before synchronize_rcu():

psi_trigger_destroy() {
    rcu_assign_pointer(group->rtpoll_task, NULL);
    timer_delete(&group->rtpoll_timer);
    ...
    synchronize_rcu();
}

If Thread A calls psi_schedule_rtpoll_work() and gets delayed or preempted
after reading rtpoll_task inside the RCU read-side critical section:

psi_schedule_rtpoll_work() {
    rcu_read_lock();
    task =3D rcu_dereference(group->rtpoll_task);
    ...
    // Thread A delayed here
}

Thread B could then run psi_trigger_destroy(), delete the timer, and block =
in
synchronize_rcu() waiting for Thread A. When Thread A resumes, it sees the
task is non-NULL and calls mod_timer():

    if (likely(task))
        mod_timer(&group->rtpoll_timer, jiffies + delay);

This re-arms the timer after it was already deleted by Thread B.=20

Later, when the cgroup is removed and psi_cgroup_free() is called, the
psi_group is freed without deleting this leaked timer. When the timer final=
ly
expires, poll_timer_fn() will attempt to access the freed group memory.

> +			mutex_unlock(&seq->lock);
> +			return ret;
> +		}
> +	}
> +
>  	smp_store_release(&seq->private, new);
>  	mutex_unlock(&seq->lock);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710134945-psim=
on-fix-tj@kernel.org?part=3D1
