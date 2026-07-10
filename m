Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391E3CCA13
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720499; cv=pass; b=aK8bYoEW7xR5YytHQC/N0Pz02gioYGSdE0/Nr9vNkm2d6JW63trnygyA8vRKQIfYtJHGKkUJNaUw6aXvC593bBSuzlzBclFRTXu1nOagv1YsS1O+1zWtYQIU4e1oA/VvQOzxa8WLPL7nxZ1bttiDnF/iMI/HI3fNOSh3Jcucijs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720499; c=relaxed/simple;
	bh=qtXlRGsP45poZpzMhp+TRmhlJjd+GpEmm13CIx0z9bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/9tZrMsycXy75EXiQSR1YllaTVWYoDFiIxptoB1uDQ5Kl2Z7FMqz8S1pvtW/1npljUVZBix16bx5//wFIZKwATDWS6nJOf4AJV35UT78sNC7WPs0s3svNSiu+/f8wYjEI0DgZeViE5tYS7cgE8fZmTYm/ie+BA0yoKZrFtIBI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USpsmYO/; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USpsmYO/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-381ed661712so1802532a91.2
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 14:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783720492; cv=none;
        d=google.com; s=arc-20260327;
        b=Fioo6ozAB1WkcROUhgI/mZJ4R+SGsW1cfL+1IwbIRj0g7iq6AUArU8mpAIaRlL4xEf
         K0qZC7rh1ITzHzrAhDxCxjCBmYnmA8fetbjsL2VWjg8iW1+Xi6lbuzV+PnNsiy86Dldq
         I9RDYXCVs0/FIwTnt2oaf/KA5iPHWzLanHmrICJcClHup8UdEnzyCgBTipGBqNyg9fZG
         OVd0bISgT4fa+rZI0H1vZsjbr0gI1HpG2KT4cHWCQbLlSqv7WBgBO67BpLpQBx3MnSjn
         k6IMQrNYWoSv+pMcIKRotckD9xBUtb0fgLCxw+9Ot6K1EvQho1jHjfasQhTg2c3I9bnS
         cbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VkfDYAglWulYlcWmnlV/C8VWVl5k+ie/vORby1dIXJk=;
        fh=CRRl/UeCLUFEBs/ER0rx4KRnfLas9f5QS3M3yGds7RE=;
        b=UkhXocfmO9wkQNO2sV4TQGq3dl6p9dY9iig6GxoVRXOofZqg8+ckqgi8CvV50i1RcE
         Ok1IcvwTjSkXsjywzR+1+JX/D9EFkAUYPybdA0GNyzuQ4/4gaHJOjfsY2NRueW0zL8ck
         M3sCGY4Vlqog19SHLWhn06t4soYcxmWDyDmyKw2RhZ87QQhgWjHRsKd9bKsFQKoWeMSk
         qLyxFksNIlYvRLxbLkbXIpgpB4Z8QoDXlAdWJ+6rfqUBnIJob1n6oRDl5fV7i6M7In8D
         2QyVE/YLo9ZNK+z86LTEcKyrloOSxRjkiR/dwt4HWPiMHH1uAmBVJWHDVQh9McF5K6zs
         +95A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783720492; x=1784325292; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VkfDYAglWulYlcWmnlV/C8VWVl5k+ie/vORby1dIXJk=;
        b=USpsmYO/FjThOWxHdJbG4h3Q/rD7pfkOL5qeXWjTUUEM/+bXx52n4lKJ58p2H1i8aC
         Oem2gCzBL0MwEADYbaxJPcWrH1F8TB8VYpMtChHnxMqTi9+T3JSf2u+z/Z7TlqMA1go8
         dVIu2HBnrnuTU66Buo1GhucKnd7vrn2G7D2sVAa5jHtyp1wUw2MPZpxVCk6JtX7g+Q6u
         x5PDmZEeGUCbtE/WVW8JhhxjuEUxoBSFCRQ8NlChOw1vPPqxYUz9iMctqbTuH36uNO8R
         gkIypvidsELEj23rwE3Pp4/UEHxQaHHODCqXytAZdW3FDUpjBFlMXDPSQ+LK/XRCevsB
         uFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783720492; x=1784325292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkfDYAglWulYlcWmnlV/C8VWVl5k+ie/vORby1dIXJk=;
        b=JkDe6KtdMUjV167x2xhXnJxGRmgey/L4xKb9GUGF0U8exvXrL4nGX8YTQR6BOaHZT8
         jkZBINDz/hPao53mcd+X1iRZgOlX+JMEBU86zV7lDIPBUFon9t78DTgfuVJ2ub0vIJPR
         fe4znxNMu72RBqXjTu77IZZ02MguTeKoeg7t9ct1I++jSudYttlwCElZVthqgC8JQNkO
         uHkkLfw1Yd+D2fzuBokNAeriguSob1pPFSlx1YrQ4pxwPTh3UKyX9v+pxVIXSPLzyLLM
         28S/69kCd60z8HYiaAy9umuTduLtOLWEOL61UmNZtdgRHlbyuQotYA9Qt9rzBUomCuBO
         V9Wg==
X-Forwarded-Encrypted: i=1; AHgh+RoS9pwCbHX1skjsPIVV5jdnlU1N9f9dK6q0OuTMjkpn1q7OszBXmR4Qa/kFDf1kL0xcShq8/BUKnLE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzF3b/R4vpOuypHkDCVs9+gJVljHPjXJg/O2OY/LCm1E5nYoQZl
	dc5wsawLaMIhV0B/TRwYPfPu2s3GwTxu26Fp90+Glr7GfYC+82G8XUco2SvQnPapBq7PWJLFlg8
	9Kk5w5NAAOsKbmSMkrDWgos+hwR8Kjx7jLz0QgBw=
X-Gm-Gg: AfdE7cny9R8f8V1mn/YF93SU+rH2mPMciPv2pP9CBYEl/I6fYtNxy6cbEYTlmBR9rgH
	c7KWOK0lz1Zkfmv3FE5r/jEM2ENeOkMLwjT+uzPbcI1WWDnrUxr3S96V0e2LNwI4JnzXluDjgtK
	IDGHCiqkWoCLnatjre5an7lVJaFcGU5OIqLDlvc/t0iouT0K7PmvoE3rhwcvEu3JlnEqQeK1uWv
	7QuQrjn/ZS2qLf9niCPxovpyz8kHIqZp55fB0zezdm395IRFy6EwD7cpntF1jjktmDdj0jPKFMP
	icAXhlafi0wIFDVS3mszOHtSEpPTESdIsJcFtHcoDOllOK98FLWqXXhrB2N0LG/PwG2YKpiqsc7
	5o/VL460LdfuA2tcGOweQTSAA
X-Received: by 2002:a05:6a20:431a:b0:3bf:6936:4f5f with SMTP id
 adf61e73a8af0-3c110a4b128mr699605637.17.1783720491672; Fri, 10 Jul 2026
 14:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260710083913.30573-1-arighi@nvidia.com> <20260710083913.30573-8-arighi@nvidia.com>
In-Reply-To: <20260710083913.30573-8-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 10 Jul 2026 14:54:39 -0700
X-Gm-Features: AVVi8CfUTnNuW64vna_tCvuIMqQg1AejiAzxKD6hVlVH9SFJ61DhqxoWeNQlIa0
Message-ID: <CANDhNCoiA5fqRYSM-Tj3cyJn0tViAgCgbvqK8t=zF-eoTQPTwA@mail.gmail.com>
Subject: Re: [PATCH 07/10] sched_ext: Add proxy destination query kfuncs
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 1:40=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> BPF schedulers admitting blocked proxy donors may want to know the CPU
> or cid where the mutex owner will execute.
>

As I mentioned before, this probably needs some more context as to why
this is useful/important to the bpf scheduler.


> Introduce scx_bpf_task_proxy_cpu() and scx_bpf_task_proxy_cid() to
> return the CPU or cid of the next mutex owner in the proxy chain.
>
> The owner relationship may change immediately after the query, so expose
> the result only as a scheduling hint. Return a negative errno when no
> valid proxy destination or cid mapping is available.
>
> Provide compatibility wrappers that return -EOPNOTSUPP when the kfuncs
> are unavailable.
>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c                      | 28 ++++++++++++++++
>  kernel/sched/ext/ext.c                   | 42 ++++++++++++++++++++++++
>  kernel/sched/ext/internal.h              |  6 ++--
>  kernel/sched/sched.h                     |  2 ++
>  tools/sched_ext/include/scx/common.bpf.h |  2 ++
>  tools/sched_ext/include/scx/compat.bpf.h | 18 ++++++++++
>  6 files changed, 96 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3d72f64ffe627..39e2689ea6c3b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7046,6 +7046,34 @@ find_proxy_task(struct rq *rq, struct task_struct =
*donor, struct rq_flags *rf)
>         return NULL;
>  }
>
> +int task_proxy_cpu(struct task_struct *p)
> +{
> +       struct task_struct *owner;
> +       struct mutex *mutex;
> +
> +       if (!sched_proxy_exec() || !READ_ONCE(p->is_blocked))
> +               return -ENOENT;
> +
> +       guard(raw_spinlock_irqsave)(&p->blocked_lock);
> +
> +       mutex =3D __get_task_blocked_on(p);
> +       if (!mutex)
> +               return -ENOENT;
> +
> +       /*
> +        * @blocked_lock stabilizes @blocked_on and thus the mutex lifeti=
me.
> +        * The owner is an atomic snapshot used only as a scheduling hint=
 and
> +        * may change as soon as this function returns, so wait_lock is n=
ot
> +        * needed here.
> +        */
> +       owner =3D __mutex_owner(mutex);
> +       if (!owner)
> +               return -ENOENT;
> +       if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed)
> +               return -ENOENT;
> +
> +       return task_cpu(owner);
> +}

So, I'm somewhat skeptical of this. You do disclaim in the commit log
above that this is only a hint and it might change, but I fret it
might be to a point it's not worth much as a hint.

First: you're only looking at the immediate mutex owner, not the
actual runnable owner of the full chain.  So current could be on cpu1,
the next owner on cpu2, but that task also just blocked on a mutex
owned on cpu3. And the task on cpu2 may be about to migrate to cpu3
(where current should ideally also proxy migrate to).  So I'm not sure
what such an ephemeral value might be worth. Again, maybe the
optimization you have in mind is worth it, but it probably just needs
some additional explanation in the commit message.

Second: The blocked_lock does stabilize the mutex lifetime, but not
the owner's. Once you've read the __mutex_owner(), without holding the
mutex wait_lock, the mutex owner can be releasing the lock and then
immediately exit, causing the owner dereferences that follow here to
cause a UAF.

thanks
-john
