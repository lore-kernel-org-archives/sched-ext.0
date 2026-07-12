Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784624113D
	for <sched-ext@lists.linux.dev>; Sun, 12 Jul 2026 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783879233; cv=none; b=RaC+woD3LqWrSR+sOCtACdM6emgB/JLfVI12KZWJIxNrU/5xVIg9o8wxC7NJ0izsktxuJ+rXGY34GDtS4YmaN9C/63u/HIu533fcVfXdaDNXDWvFtqj0VAfXETtwn0yQQgMtH8VInXPiZ8NdU/i1XTZIojPAL1+alUPZbHnIaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783879233; c=relaxed/simple;
	bh=OEY2KBRrvsr8X6bgFE1FFjArhTG8+tLY2IhwYj65m6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pfuioMkXriUAvEgPN25YaxZPxyXuGanpBXhRz4KTeQeI9sVQZtUFKONfV3xU5rdyR1IoUkccy2Mkya3AvTC0q4jvaQTz5C9X3DiYwsOEE7yKSr81q9Nl2wEAcfNOr8s21+A+iuBH9gv/SqsMknMXL2fWuujc9ZlLHj+oneJjS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqgNoVCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqgNoVCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087AF1F000E9;
	Sun, 12 Jul 2026 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783879232;
	bh=Ks7/YGmAlI82d2QKHaZetGR9gojEe3jVWRiuwM2Drdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DqgNoVCsTnUQ8/7XbZEpZ498KkiFcfeaWzcRJ0Bu7eoOyuyvJfTtEx1HAOhxl3BD+
	 Qc6bWGybm554Z7bB626fWmP1uYp6Y0OHIqCQOGBRSFPL419jO9c/izjxpqf1DsI2Ly
	 zYqZILPz+UgwGAksnInsqsJvYICI9Lw+Y5tjXZ0aiAtddN9w2eYFSEWUQA+IvUj1+n
	 +U/7whmF7aRdWoU204xm2JEAfnfXtUeegG58eZx8lTnAPJtnJE3D6JJJa2W0SC5m4u
	 mmc0nAfW/fx0IvRJLBPUDsMrEk8lAqPay2q2WfuO1m2FEGq5O1Qy8TJmCjnc3HbS3c
	 JZo6scpwdJhDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched/psi: Create the psimon kthread outside of
 cgroup_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, tj@kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260712174619.3553231-2-tj@kernel.org>
References: <20260712174619.3553231-1-tj@kernel.org>
 <20260712174619.3553231-2-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 18:00:31 +0000
Message-Id: <20260712180032.087AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling psi_trigger_destroy() while holding cgroup_mutex introduce=
s severe system-wide latency spikes.
--

--- Patch [1]: [PATCH 1/2] sched/psi: Create the psimon kthread outside of =
cgroup_mutex ---
commit 4990aba341f12c025b0b99ecf8869c68be847294
Author: Tejun Heo <tj@kernel.org>
sched/psi: Create the psimon kthread outside of cgroup_mutex

This commit splits psi trigger creation into two stages to avoid locking
dependencies. It drops cgroup_mutex before forking the psimon kthread, then
reacquires the mutex to verify the cgroup is still alive before publishing
the new trigger.

Closes: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readmodwr=
ite.com/

> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 38f8d9df8fbc4..b5b461d4418b1 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
[ ... ]
> @@ -4015,12 +4016,32 @@ static ssize_t pressure_write(struct kernfs_open_=
file *of, char *buf,
>  	}
> =20
>  	psi =3D cgroup_psi(cgrp);
> -	new =3D psi_trigger_create(psi, buf, res, of->file, of);
> +	new =3D psi_trigger_create(psi, buf, res, of->file, of,
> +				 &need_rtpoll_worker);
>  	if (IS_ERR(new)) {
>  		ret =3D PTR_ERR(new);
>  		goto out_unlock;
>  	}
> =20
> +	/*
> +	 * The worker fork must run with neither cgroup_mutex nor the file's
> +	 * kernfs active reference held. The latter is broken since
> +	 * cgroup_kn_lock_live(). @of->priv may be released while unlocked, so
> +	 * recheck before publishing @new.
> +	 */
> +	if (need_rtpoll_worker) {
> +		cgroup_unlock();
> +		ret =3D psi_trigger_create_rtpoll_worker(psi);
> +		cgroup_lock();
> +
> +		if (!ret && !of->priv)
> +			ret =3D -ENODEV;
> +		if (ret) {
> +			psi_trigger_destroy(new);

[Severity: High]
Since psi_trigger_destroy() unconditionally blocks on synchronize_rcu(), wi=
ll
calling it here while holding cgroup_mutex cause system-wide latency spikes?

Looking at psi_trigger_destroy() in kernel/sched/psi.c, it does:

	/*
	 * Wait for psi_schedule_rtpoll_work RCU to complete its read-side
	 * critical section before destroying the trigger and optionally the
	 * rtpoll_task.
	 */
	synchronize_rcu();

If this error path is reached (e.g. by racing pressure_write() with cgroup
rmdir making of->priv NULL), the calling thread would sleep for an RCU grace
period while holding cgroup_mutex, stalling all other cgroup operations.

Could the trigger destruction be deferred until after cgroup_mutex is dropp=
ed,
or handled asynchronously to avoid stalling the cgroup subsystem?

> +			goto out_unlock;
> +		}
> +	}
> +
>  	smp_store_release(&ctx->psi.trigger, new);
> =20
>  out_unlock:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712174619.3553=
231-1-tj@kernel.org?part=3D1
