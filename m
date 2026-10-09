Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D564440638
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554514; cv=pass; b=A1dTxqpusbsiL7yMHfh7OG7A9dibWM/uSmYFdldqb3EXFNLCCHL8v3EZOqsydlBY0JQmrki1M7tWdIOjMiI2f0yvk0Tpw7CndGK5xGYzuPV/CJl4iaCe6k/w1PI5kQSK2UpVGgNPSJvJr5wrB+e3CZA+XY/GL+Agek7k91eJVJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554514; c=relaxed/simple;
	bh=ITqMKvjpOuO0AQUkP3fW5wgzA4k30wtF5NYHyj6W6LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNjOfHgKKBHO8BBFHQAKrLsTyyU3LYUGwyfAj+PevF6urZo1CuCXBoPbNNRvdTvq7j3+Haf96yX/2ZU+9zZu9+fw4rLL7IRk3ZXj/IKaNbCgQw5+QpHoqxfaZ+9htYQ7ieTVDZdaJEBSubNBhIi38OyBpHHSldVWaRlVgxz55m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JA5mOMWb; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JA5mOMWb"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6afb0d2a586so7949081a12.1
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 07:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554512; cv=none;
        d=google.com; s=arc-20260327;
        b=Kf+UcJWbcfqJWTbkC8ceZkZ9gCc5hcSJnKsIXX+qKwM4oK3Vb5/QKmjiTMXVap619b
         RAhEDpBlsDW+QYHcfsJ9VO7TrTdOGvjiDLrBnD+GYhA2mAsLCqLIzlb4a91v2s1WdOdz
         WumRilIWbnMc6jsuNYLxZnoxSATAbsrhR7rOYEhNnVdxJYIXq6Lkdoxs+4nprUKLjwLl
         zyY2QRTmqszIDvOemHQh+09bnq15GFxCLlB72kkkaT8AghK5I+yEM+tkrHGiklkXYr2e
         ZNl5tnEb3SnN8zaMyGnZnAsjVejaIB9Ok6qG1f+2yBwwwCUyt7abm+Y6Bu/S5LKbBPhi
         9sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VCymc19pFg1e7iTVrFtMCVn58qnf/FH0ex401YjyIug=;
        fh=Mrrwp6YrdUZvplAXJWR0bJLIGybzvcYHDhmnzIgmjOM=;
        b=e+it/tFn5aQUstqkEX8EWYLtH9ZtEaKUr2cTRWmaPIbk9penlnN4/l26ZOoWc7ReZp
         2fzYOMl88bRBdopnK5/N2pjK8L2CI31DrWWWL3rVMV1KyPHKAYZ1hXqEilY/9iZ9GPQ9
         JBo3HjwPNm6e+xJ4dU/vZE9wj7hM2bJytNOmyEcJdmM4FwSxohb1FwY9BkCdhNq95dg1
         jp0O4U4AegMcqo4kF+HLEEWsYf8ccufR6BBEL7Nj9ypnDBASr2RbGFhJY7MV9oVCMAIV
         UckENV8I9pM45GfeiPWIsmJeyGmwnyra+piJkGm7qBx3BY6vLhXYXPcknFXZN3G8quGz
         Qbzg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791554512; x=1792159312; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCymc19pFg1e7iTVrFtMCVn58qnf/FH0ex401YjyIug=;
        b=JA5mOMWbIQCxR21+tMJ+lrmrdwX9dh0xcY5xYZWTF026IpEw+dmcV9mgmwt30asM7d
         0OHLuAu0f25y5FTtgPL2/e/SVGxU6+AcgNvWVlNKAv0SNzg+ZM1aS6SeoofZekKjs/Ov
         Ol9bTLokg++sBcoajGhxPgCzxNwh/95pJyJ5b+LuVpDkHx/Z1f2QjCoHP0c7Mku7Roi3
         o7W7S/r3yhdUuZfHeDNcjSUta8Eo7R5wDrzgHGUTAi2KD5OGltfIecKPYv3JOZK5PKWk
         49r4dq3IQhUFMWSJrj7AlEl9tXrBldklD8KM4iuAs2mX9zwODj9VBAZaHYlN9XQcJLD8
         sMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554512; x=1792159312;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VCymc19pFg1e7iTVrFtMCVn58qnf/FH0ex401YjyIug=;
        b=QVqjQncGBZT/8XZgoGRVLHMvp0bshkvtumjKuA2mm/BBZUfww0hJbfrD5IvWcI7t7J
         zTP72I6fiADxMvW2qfKm89Fee7251vPt3AUQn/NWm5Gx01k9007uOkrm54uuSAek4UNN
         px0dCgv2UGM/AR50rH9FpTkLvWC5mQXywkIr5B1LREe0L8F6QgAapkZstbnijqr46x8k
         kN6+Jkw6AXZ3G9R+sZw1v1oIiy53iCvveyusD+neaFIx99iCcrBpcjQET/6FCPpbJaE4
         2j2AByKD0r/d9JQhX7jz99SskVZVmhKUN5wUA+KElXAI1sNJsYdU61bM4Fzn/1JpMfyF
         AlHg==
X-Forwarded-Encrypted: i=1; AKwUvBz6sQpFrkB6g2+aJmScGOW869CwZKZ24gDiPgvFKUiF96I3BFKHnhr4rNuxeAhktZmWzeUFN9G8bwY=@lists.linux.dev
X-Gm-Message-State: AFq9FYK/VQcZuyA+fQ6gHn3gkfigGtVe/BrgCtWaiQP0etM28lJNWyA+
	+Wg0NIhn24iDeBQ/g9UIcIsBG1zxa+nA1vldi4S/ZUyc0m/xUC21UqQmmP86zkQBFct3qIDz2pe
	TArEoh6JUDeuV7VnCIq6Uj4FuamJz1wfd3W681k+UUA==
X-Gm-Gg: AYBFou1CcLi/+wIOLYw8NWf+/Xbfnj1wGmiK706mq3R08pBzczmcum7t4eVP3owKwfx
	4D4nzzR+W4lndiqysYNt+K+XLJQbmNLkEm5OLfzlDnw1K7xlW5/t6ezBQzxwC9ce0Qd4Qwn58+p
	99k8fp+5EZBTSsc2pO9WSGC+kyEyN0lVPmPT7nGEJFD4yM+toLGIHZf7ZptCNSpaL9CkNe6Ec/q
	bQwkbxXDeXGeCBOiVwYFJTzNOdPHiasr88Nte7jPPoVI52hMxQxHSpXocH2j3IT4VY6BwPHYIoE
	Y3mobf23oMLHgSYhKoSFemBYyw6Leg1ycoYvFCiSyqR7X/YYs14b20pUUgh8lYkav/iBn7qifti
	JxfxjUl0++9I=
X-Received: by 2002:a17:907:97c2:b0:c2e:2b9b:f16a with SMTP id
 a640c23a62f3a-c31aa0db298mr219331566b.39.1791554511699; Fri, 09 Oct 2026
 07:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-11-vincent.guittot@linaro.org> <20261006192414.7308-1-kayracizmeci@gmail.com>
In-Reply-To: <20261006192414.7308-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:01:39 +0200
X-Gm-Features: AclHuK9YZ_WP4WP9H5H0CuoIx36QiVr2v73i8ApazR67nIerBidlId3PkJRLutQ
Message-ID: <CAKfTPtCqz8AVqzo5gEfidftPj2Uebd+QDZs8RKmY4mvi01QRDw@mail.gmail.com>
Subject: Re: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com, 
	christian.loehle@arm.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, pierre.gondois@arm.com, 
	qyousef@layalina.io, rafael@kernel.org, rostedt@goodmis.org, 
	sched-ext@lists.linux.dev, sshegde@linux.ibm.com, tj@kernel.org, 
	void@manifault.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Oct 2026 at 21:24, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> > When the task is alone on the CPU, it's never put back in the enqueued
> > list; In this special case, we use the tick to run the check used to push
> > runnable task on a btter CPU.
>
> I love typos. Like, in here. 'btter'. I think it should be bitter. Like:
> "In this special case, we use the tick to run the check used to push runnable task on a bitter
> CPU."
> (Or maybe by a really low chance, it could be 'better' too. Maybe tho... :>)
>
> > +static int active_load_balance_cpu_stop(void *data);
> > +
> > +/*
> > + * See if the alone task running on the CPU should migrate on a better than
> > + * the local one.
> > + */
> > +static inline bool tick_pushable_task(struct task_struct *p, struct rq *rq, struct rq_flags *rf)
> > +{
> > +     int new_cpu, cpu = cpu_of(rq);
> > +
> > +     if (!sched_push_task_enabled())
> > +             return false;
> > +
> > +     if (!rf)
> > +             return false;
> > +
> > +     if (WARN_ON(!p))
> > +             return false;
> > +
> > +     if (WARN_ON(!task_current(rq, p)))
> > +             return false;
> > +
>
> OK. So, this is called from task_tick_fair() and task_tick_fair() is
> called from sched_tick() with rq->donor. So on Proxy bla bla
> this could get true. Or maybe I'm missing something. Dunno.

good point


>
> NOTE: Some more places could have the same case. Again, dunno.
>
> I need more tea. And sleep for not having to drink that much tea.
>
> Thanks,
> Kayra :>
