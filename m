Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BFA34CFD6
	for <sched-ext@lists.linux.dev>; Wed,  6 May 2026 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101797; cv=pass; b=N9c6AvramDBZEXefdy2NdtOFk2FmJR7r03tDUvbw44WwYdB0WoFZs3iJ/BnZVRsTwr9nYD/CsxUyg/y3PuTiaRsxxv97LxWtqLbn8mV/Y6uYtgQJrQGDrIe9bEmh7ocoFHHL6HOwNzQoBChPV4NJakBScTS9T+GR/H7TwgpFBow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101797; c=relaxed/simple;
	bh=lSKLoNuMTZpXfciw667KhrWK98DRDFQoT7A9O7SXo1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqeK6jOTNeHVgFUHePAPfMGyaYYEo9xN1BZD1S3oDtzJZckzLt1WlOIzzJ6gLPiB6E+LeCZaWolWRmz+ysHCMSkQbGCFN5WuZPYt1i4xWnSF1rCkcDliRDjqp/F8zTd97nDQiB6ke6UtbV/ECHZoLUhInm3vOAiWcM814tOzs98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2x5wfYT; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2x5wfYT"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c88e5f4aeso120566c88.0
        for <sched-ext@lists.linux.dev>; Wed, 06 May 2026 14:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778101795; cv=none;
        d=google.com; s=arc-20240605;
        b=Jr5wX3RzzwQD/j/uu/UfTaOOEA4613YoycMOQjH7q/VG3SP3CrmkV5Z+RUj7wcyNfB
         a5JaCLq6hs/itjgROAinFforkcQow7i9KN4fTh+CX1wzhMCajIUPS6Rkc8XwWPcgWlPQ
         HjZ/gM8yh3yQKKLdXZFAH5dwVNMCiWohpG+szgccmqBRV+6WxCR6EM2IcpbmnzSPM/Si
         uqs1d7+3awJ3kVZSGq28wzoELwJmMNv4i2O6KxcGyVgAzZQjNCLSxpbr1BT2uBk7qFSy
         uyZcrHFaiTkxCCLVwcryZbVpeR10qmINUrqqNbd5yCY4O1NEE/jUmb9djJbWaJTnerDy
         Tn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2fdVN7Nni+G1oaSiNaX0JQJTqXxq6ThVYL4+e1OQX3g=;
        fh=1/VGU4LED8v96lJV7Wl9vxWWhEVmFydRK1+ODyQohp0=;
        b=PQYFyFV7DHvNZxPthLu6dXWlhwMif5OIwc+4Y5rNjY4YcJCX7la3mu3zx+BqBXlFjW
         PtYQMmL7TjTSWlniWjPn42OAPrsZkF5xRC85fzmSVeo6KG0yoLRaLNNxn5639VNKwoV+
         iEm+uxSr5cqk3Lbz1kv5XoqMqIc0o/n5VSzt6um4+eij0je7qD925XB+a/HHu1nAp8m1
         kOewASrnZ1GLFgsHzLdxjPzOjrdxCZx83Itpd6F+T9CP2Z/ImWHylX2HdW5MdfdNxI+8
         eB+oKwo/GDbyqu6woBW8ZEyKQLak5xUCwrkcpLU469wtdVHAZcR1sOYBrczG9ZhB6LpB
         5uAA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778101795; x=1778706595; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fdVN7Nni+G1oaSiNaX0JQJTqXxq6ThVYL4+e1OQX3g=;
        b=f2x5wfYTxlUVkkgEYbxfccXiultDUR4eYZqIVgvNsji+rfJex1MCNygWDASyL9V5FM
         Kecua8Wtfw2m/MT4GZKSEq1QWqu9wovHp8QOHF3wMKkHE8Kau5XC+qMqculA7VaqKSnC
         8O+dZCSb7l1YpqcdtuLr974ILRmO/ofJ/fVPnlvk78uTsSuvxHA2py5Y5//70djmUxsE
         p3IdnBSYWV1cyfI/Dp+889z0VhbQM215hiAMpwAyexcKyT3DPX4MCTtp5J9NUsYyodt4
         W40guyAJtLGQ4IWpiphnyP5iUG6eMWKfZFF02H14knFFi80LfqCh0/dh3LS0bJol1ew1
         p+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778101795; x=1778706595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2fdVN7Nni+G1oaSiNaX0JQJTqXxq6ThVYL4+e1OQX3g=;
        b=tF6AcOu9SwR1Srp8KzWgTfcbN8zJp+lcjnUo63WcHu603BjC5Cem/Vof9qnU6GIVZI
         GKExW1QBT3Pf8g308p82smaVehMAVJsdvm0A6wgJ4I1RcxViLZM91z7Dt172ATSQERaP
         pck2dpxTj1PVd/2ORLBiJ/CN2NB6F1dlAXedeREBr7k66r01zRL5m2SttqlKeBjyV4IP
         0dtQQCaAHvTEZJm5qX980olNFXb8ypcr5NE8sXfZn3yZH2x8CPV5q49DxWMWedDrmMwG
         ykfl+k+x+pXwQF2ZU/Gip3VqEJo302/MIQCex2kywf8hJCUhHiReQAcM+r6wAJx79Y5B
         OdgA==
X-Forwarded-Encrypted: i=1; AFNElJ9Tg8RxZN/B5MLiIJykg0jKemPXcWfL1tzQrebkGl2NK6T3stZ8pC8bTn5+oPOWkA1IhSvCi00QDS8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzdKcwipuugoxgGPFtj/m9C6KnByajqlBctjFSBnSGqnUqj1nvh
	ZP6YlW5lk3PWDHdb0s0xV/8hKTnj8U6WGRQTQrZfeE3YT6XWnSvMeaqFKsSh9avIiVSZMcL041C
	3z9rExccFYh7BrMPdDqJ9Bi4rZic2E6ugGK641wY=
X-Gm-Gg: AeBDievwsy8DLMc8s/zBW1GMVz49BvrZtjexbq8jA4rCaAWWleM2AEfGmFGK6KGx1Fr
	LhdIjYcEH1kp+euciP8KNmxoseQGPD3sSZT1dUmz5ZKtS8uEP4jCKvXDvgYR7NSg4/OzRif+5h6
	SX2Sm64GEFQFA8raQmdvPYRzf1tusC7ZEtWmXbNUul6yJPMfckKX6pv0lsXiyWewTHlx7VAr+84
	89OLA59m3FkiZ9dbTflT46ZT6XyXyzIE7jtuR2jwILAShu+eFS9f/EyYaH3RtQ+QeiLiu3BKahv
	8HWjEWsZMyS2m+w5Glaoh1zY3Ta3quOUpadQbw/e0msAps21OaVlaEDCRGEdD6K/AnHCWr5lr8L
	ml/sOKf7zO2o7TDyrjw6/IYQ1pb1WNH0p2JB0z8eetNhtius+4pXWK+hB
X-Received: by 2002:a05:7022:624:b0:12a:6d05:3941 with SMTP id
 a92af1059eb24-1323aa56de4mr114658c88.2.1778101794734; Wed, 06 May 2026
 14:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260506174639.535232-1-arighi@nvidia.com> <20260506174639.535232-2-arighi@nvidia.com>
In-Reply-To: <20260506174639.535232-2-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 6 May 2026 14:09:43 -0700
X-Gm-Features: AVHnY4IcwKVs_Ao8f_TdQKWA5X-jMTaKjoZKkaRbQMdb_ZSSmOuZTXO9K_MR8gA
Message-ID: <CANDhNCoKyJGZApptPo=7S-Cdu1FqPPr_Wr9djV1-NzjfVnbkgw@mail.gmail.com>
Subject: Re: [PATCH 01/10] sched/core: Skip migration disabled tasks in proxy execution
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, Koba Ko <kobak@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 10:47=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> Never attempt to migrate migration-disabled tasks or tasks that can only
> run on a single CPU when switching donor's execution context, preventing
> task pinning violations.
>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index da20fb6ea25ae..75541e5bb66d1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6793,9 +6793,13 @@ static void proxy_force_return(struct rq *rq, stru=
ct rq_flags *rf,
>
>                 update_rq_clock(task_rq);
>                 deactivate_task(task_rq, p, DEQUEUE_NOCLOCK);
> -               cpu =3D select_task_rq(p, p->wake_cpu, &wake_flag);
> -               set_task_cpu(p, cpu);
> -               target_rq =3D cpu_rq(cpu);
> +               if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p)) =
{
> +                       cpu =3D select_task_rq(p, p->wake_cpu, &wake_flag=
);
> +                       set_task_cpu(p, cpu);
> +                       target_rq =3D cpu_rq(cpu);
> +               } else {
> +                       target_rq =3D task_rq;
> +               }
>                 clear_task_blocked_on(p, NULL);
>         }
>
> @@ -6893,6 +6897,18 @@ find_proxy_task(struct rq *rq, struct task_struct =
*donor, struct rq_flags *rf)
>                          */
>                         if (curr_in_chain)
>                                 return proxy_resched_idle(rq);
> +                       /*
> +                        * Tasks pinned to a single CPU (per-CPU kthreads=
 via
> +                        * kthread_bind(), tasks under migrate_disable())=
 cannot
> +                        * be moved to @owner_cpu. proxy_migrate_task() u=
ses
> +                        * __set_task_cpu() which would silently violate =
the
> +                        * pinning and leave the task to run on a CPU out=
side
> +                        * its cpus_ptr once it is unblocked. Stay on thi=
s CPU
> +                        * via force_return; the owner running elsewhere =
will
> +                        * wake @p back up when the mutex becomes availab=
le.
> +                        */
> +                       if (p->nr_cpus_allowed =3D=3D 1 || is_migration_d=
isabled(p))
> +                               goto force_return;
>                         goto migrate_task;

Hey Andrea!
  I'm excited to see this series! Thanks for your efforts here!

Though I'm a bit confused on this patch.  I see the patch changes it
so we don't proxy-migrate pinned/migration-disabled patches, but I'm
not sure I understand why.

We only proxy-migrate blocked_on tasks, which don't run on the cpu
they are migrated to (they are only migrated to be used as a donor).
That's why we have the proxy_force_return() function to return-migrate
them back when they do become runnable.

Could you provide some more details about what motivated this change
(ie: how you tripped a problem that it resolved?).

thanks
-john
