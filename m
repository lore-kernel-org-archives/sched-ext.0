Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341ED3FDBF7
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617260; cv=pass; b=gaBl/TI2fi3aLFyuGC0vNmNxUAwW95ZxM+fDZUGENeZthqf6yFpA85JW1G+x9r4QiutxAppTNr19cIUWcAdeDvvHnvT9aLV8V6qxX22yXYEQu1HWmwYBQE+USLdyB1UVuivGyn/6Z/wBMvJf0JG8IDvt9jikB8ldZ4IfJT80KBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617260; c=relaxed/simple;
	bh=KbW8qDpBz7dRQJmz6VBWRl9vWxLvs0K08mcBtFiOVAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mkg9lHPqBvAO/GD9GgLwLbHywiEn8RtbsrXzm5DALDE19wP2iPjewfVdJefY0K5AaWB7n4ZzDgPQYcPsaWJmmmLcLnJ1IQEkt3qfySnRtjgT/dfSBqeCAwANVS1x/mPo0oxWbJnfblKTG9Ktdgy3hHO2t2i1J937GWBTm+nXP9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVXp4QXc; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVXp4QXc"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca7c1176317so8025512a12.1
        for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 00:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784617258; cv=none;
        d=google.com; s=arc-20260327;
        b=snOB469pfl9P/oM2agu2lzdj9ijj72rkDc46774JamTRQoD9LMuoy47H5JOT1JVVk3
         BUsNxZnT6/5kER9eetaFFod5koMDrwuQpEO1R+ie3e27Yua7Q4US0KLqojvNYQNGIkKY
         pAUabBJZxK5kHOdNBQQGJ6izFpauOG6pJ7tAlcP/p03SGbYsZMGlHBk/YIgMcyKnXEm1
         UbrcaGyzdyxMK0LIt29uXp6VyH4/+l7S5Zk46NXNeEDRe+mhHWo6ADGEBq6tTPVY61sI
         PpIVPn0jDcfa3eMhyitDKjUBnK6V+89cl4NtQPvQSs+aUELA5KrPEUlT7lw7oTVRX5kx
         9fBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KbW8qDpBz7dRQJmz6VBWRl9vWxLvs0K08mcBtFiOVAg=;
        fh=1q7SpAh5c8swSn96Ju36J4AqL7v5wngHbp0vDlRS8n0=;
        b=DECC4deqBtd8mSjBdr2G6wTBUxGwhz8H/8ooBBgAZZo5RRlEFKtCKus1HptW+vdk4D
         vdNLsqDixpVwTLXwRIezJpkL6+RUWIfk+eOfcHQ/LA8qMrLDvUa9xZL64OZq+wEHVpr7
         vMaEep6jBEyltRo0eDlMNNfFjWHvdEZ+xsYAmeJUVET2li5D0FxbBL22iV9S6O3PFgqt
         qnFGeAOXqh+3iFuElK45rm6at16viFqowknnaRhOAFCnXTNC596WApwtVnek9lQAZ1NE
         YFncAAFSPPMFTovOiT1iOvAQcPATrnBvnCUb1KjdxRIEJZf8gt9DxECnQTFIWGqQqjMo
         iBKQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784617258; x=1785222058; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KbW8qDpBz7dRQJmz6VBWRl9vWxLvs0K08mcBtFiOVAg=;
        b=mVXp4QXcttZvySN97evYZYTfg8+C288rieIiX1opvjTkO1eK6PJhxPNNuP2wxLRxOt
         sJNxouVGcoWpfhuO1k+PArUb9JD7nsgEnEuAPwZpyzD2K7tzTABqWeY2xXv0eM4vtpQ+
         XaJ7B4WXPvNGNzbf66UtXPnV/UegrtDUB91hubPnN8s5uYD59C7FZgVGNgYYJkjcyLUX
         pPcD8fahgbdnEIWxhOWGHNcfhK7rYSOkQNiBX6uIZgmtkKcX0BuL6A3Et/sqhQMT+bwM
         Ef/IIuD1qYLnqRHCiblS61FeOaX2Ma0ZMBd6zyHjf9f0erjZ7kwxq7Kb3jLxSnS9tv13
         MlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784617258; x=1785222058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KbW8qDpBz7dRQJmz6VBWRl9vWxLvs0K08mcBtFiOVAg=;
        b=HxtUyyx4fouojJb9N/88kEJx3b5eN99mCPusjSXBAj9SJGk7o+T+1dBnhb2+Hpa+c+
         7MiwuBI0qU53v6HZLOF31VbAKJFmrD8vie/rYz3cSePJCBZYJxUQ6mQq4oY/P6VMALWR
         ZwGteaQcfZe61kW4e7cKL1u98P9HM6NWNwO6jPbv7UX88qU1nHBvp65CdO4lO5e2kmGe
         KKRZ5ktSiGJ3RFiiiXLCjSycY+9KyHibkfpMu5/ljsWXI/FCNwcHb67d3QDZLuff0yig
         4NixQGL/4iUVCh2Wy6Hficf+mMUSSXSI65nLKJgj7KseS+KItCu3cCvgGfKOl7lCXnl/
         hI5Q==
X-Forwarded-Encrypted: i=1; AHgh+RoahzPQh83A56Ctx5cXXPU6vXfmAgO1apG3VJYuIunmYx701LJNRvvxEcbzTTZVa1KcO9gfgfQekHs=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj3RfGXI1+3uBFe3DGLnWFkXjsjQkqv6wlS/gTgxr2ClgR1nf4
	lyFeqsaIKZua42D5hexscrsg9yCP5j7VHGcfXM2APL6lqX7ouF5bsthZO4saVhvNaCPHGF7FhDq
	OCSdfHGgQTnFxbIhVxf/B76C6XNj5MLT2V3BtktQ=
X-Gm-Gg: AfdE7cnEfZKqGxZ4vzAsJiGNTFylwNMd8In/NixHOZvWoZUcGCSjlkrpoSGA06sCus7
	b8xPU1kPMcodopCCw1k46W2uJKQWsQK8h8xBDRSuIf9F6/VWjHTPoRtL6q0br2WhZWCSxSwux1W
	OLmtyvTgm1LhqXuBePpu3I2PkDmda/icqMBXpOqzj3D4qGQLVeNIW/7OljNOWA2cpLZBS3kOpI1
	s08Gct+7mYgHp8vdQ2onyO0soMlH91a0ELceLyEYF0WwbTKaqvL3O040I56wCdPDBNNT1k3+iB3
	C2bfzo0Fx2St2CnEeFqQ5aKEk/TUDq22JTOunzkih6hZZXrOLzyL11TN42q+vJUtqUHpm1FtVFe
	NwMdqRtcURl6zEA==
X-Received: by 2002:a05:6a21:7111:b0:3c3:aabb:dba3 with SMTP id
 adf61e73a8af0-3c3adb17f56mr19148506637.76.1784617257722; Tue, 21 Jul 2026
 00:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260721063242.552774-1-arighi@nvidia.com> <20260721063242.552774-2-arighi@nvidia.com>
In-Reply-To: <20260721063242.552774-2-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 21 Jul 2026 00:00:45 -0700
X-Gm-Features: AUfX_mw5PGiX1OqGyERbO2IVw4mkMhqXcSxvP5BdEHQSwa_V4BsP5XVdmfQ2fcE
Message-ID: <CANDhNCpTDwDiMqFYprxir4cKtaC5smc_-G730gt1MrAyFU-aKA@mail.gmail.com>
Subject: Re: [PATCH 01/12] sched/core: Avoid false migration warning for proxy donors
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

On Mon, Jul 20, 2026 at 11:33=E2=80=AFPM Andrea Righi <arighi@nvidia.com> w=
rote:
>
> Proxy execution can move a blocked donor's scheduling context to the
> lock owner's CPU even when the donor is migration-disabled. The donor
> does not execute there, and its original execution CPU remains recorded
> in wake_cpu.
>
> set_task_cpu() warns unconditionally for migration-disabled tasks, so a
> subsequent proxy migration or the wakeup path returning the donor home
> triggers a false positive. Moving a blocked scheduling context does not
> violate the migration-disabled execution context.
>
> Exclude blocked proxy donors from the warning. The proxy wakeup path
> restores an executable placement before clearing the blocked state.
>
> This is a preparatory fix for enabling proxy execution together with
> sched_ext.
>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Nice catch on this!

I'm wondering why I've not tripped this myself yet. Is
migration_disabled set more often in the sched_ext paths? Or was there
a specific workload that you hit this with?

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
