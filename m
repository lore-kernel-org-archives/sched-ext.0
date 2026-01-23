Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3450259C9C
	for <sched-ext@lists.linux.dev>; Fri, 23 Jan 2026 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186293; cv=pass; b=K+xT26Fk3PReITV9o760UCWe8WnauqTWaBLfMSLV+jTdrVsp/TUHxRmtwVy7c1TmPdpJcdAYs6mvq+6rjbkQUoH81Ro44JORFUVJOy/wXqTm7ytWptehvqfx8LGWF3q6l3seGQJEZWwOf153OJ6JgfTJLS8QPtoCOQMyFrcC7N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186293; c=relaxed/simple;
	bh=RwDPvI0pQ8Sul1C0MMRL8oO67jL+BJknFecUZPy82xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnuFOpZpIayZlT3DJzwFbSCwDYra5bAXYCBHFuGZvDoTHY7awq/ZASdta62lg27hqqlAZFHTxtBzXenzUvaXugVz8Eckjr2+XD1v5/mPwAmR941y1TQyt1zNX/WzuSrWbtktOAy7fhABh+gD8LULBLoVJLk1zv2YJTQX2WoC5BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/YV+OyA; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/YV+OyA"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fed090e5fso1550397f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 23 Jan 2026 08:38:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769186290; cv=none;
        d=google.com; s=arc-20240605;
        b=LKHcSghuPnIH9YVnJdNrJjXtn8K3QpTm/MWrAvGj9tODDcQ4mLwQvP5gYeznkr04OU
         nswSgui6Ggv20DDQ5bb34vk2WIeHwXnG7BpzXQgfFD+Z9mRXD9YtbyJeWncIDsv3A1l4
         Um3qgHjo+N7o9pJijvhvuHg6bGNHpQ9M5c3AXHlvp86JYdoipT2AYHEIw0YSUuQa9s25
         t/hejzqXfU4RHA9jrWLJmsX0Q5Roog1aq5gOzYf3znAs90IztqDdv5+aTClpTgVdhRkl
         IpH78UhQdmSKIrPSEo05TqQ4sRDLGdY4oYUZ794pZVKP9uV0fSHZ+V1KvARhPnj9+Msr
         KcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kxHbVBBXdVDou2agKorvT80NIS3RgrK7fNwOf23Uh2s=;
        fh=VVEtpBL9JESYlxkmH7uEFih+Z7JxzsmIGJJ6md+HdzE=;
        b=j5Obt7xgummwUQplUzRC5+B/sKp+Bn3rH3f/MoFnl6H0jOnzxiCbvTdBXmTjIHwj5H
         uBqREpBk6rXuZAlACNjH+icycFxQtFsGXbc2C9BqPEdutq+VAiAjOA4lCTktjMdapvbj
         hn44ulliGBu35trwdTC4ptcFF5HDGXaIdy3ODkHQyi1lar2mihPlcOYYI946vFYZH34U
         1QqVf1z9+k7D1NfuQnle0XX+5jykK90Ajc9W7/FL2ZxzvNyvEm87ARxYiHSErB1dzQpN
         gMOLh23lkJpeqcW+eiVRYHUxhwM03Y7/0cHtC0wROiDeM5nqspON56aE8GCpD3IKm1K7
         u9Lg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769186290; x=1769791090; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxHbVBBXdVDou2agKorvT80NIS3RgrK7fNwOf23Uh2s=;
        b=A/YV+OyAKpeShV9e28PJijrPhtTvBHIGfU2tESeFQwYKq1NBshkUxkQGtprd0D0eoD
         aYG3nuUTzcXq5TfGiOhqMAAicYX7mruIucKXI9EJu2GJZEhbBvSSArBQFUp2WDnWsyNs
         pJ4vKLkh9zsPi8Pimw73y6wbdqG/SLmglH4kp5EpRzLOX6bNdTL0WqjhTR9XKu7mT3EA
         VFb9rYpIdtYUniSoRH1RbhQGLEIt6cQLB+SSAFBORLRZq41ZKzy6efqsf0CdRkK3dUQs
         Dqi0LdHCtGAaR0lSqH3QV3v6nNBA5SKgeGZN7J6+q2QJB1VJRtg9/tW+eG/+kSYcVAYn
         ntZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769186290; x=1769791090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kxHbVBBXdVDou2agKorvT80NIS3RgrK7fNwOf23Uh2s=;
        b=pRvVk3d+L67fnJrC4K1vwBw+franxFUUS7YuKqnW3cGx0Z1Y07+rUm/yLIf+Ty4Pv0
         We6W5fcaUlt49egFYuyAnyaZrxVRaE8IW+94b4LT0uVUO06tp5AZpYsy6zdYQCvg4Kh0
         RUC7ttO0m0aBOGs8z8cOgRfm2TNHBa/Tp51vzEBhpYUZj04NOHmg7UNVfNlgGVqwIrtb
         Nh8W+TZb9qsnNbmQxAAuLUqH87Kvcwjfz6ncFfngdHlHLAnYL7Fus1MOwcq1iJSTquMZ
         JpdtVWoo1/bcKzNAHQeSdmEmmL+lM60g8g4h19JVMzdeR+hPJKOV7m0Tc/lhttbOYeeY
         ///A==
X-Forwarded-Encrypted: i=1; AJvYcCWRy2AvyYMYplBPpf9TIStAlat3kuCKIEGoOuAg3SLLBlgkOESIMD9o4q1lGPbhU2xdBJL5LhowA64=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/eC4atwI9IwUcqfImL78Y7wvtIwpHYNWh2oy7m8OkTIF9Ngv+
	/A3l0+I5093PjjpKEXGa88qk2ZpLFIAtG7LlanD8XSJCR43ZSXSW3rLexAHiHJRGJyL9G4+fPeC
	ArDcmBjNI27PXpDA01ZB8euAbo6FhwBk=
X-Gm-Gg: AZuq6aIzTZVceupHQsjXYHpuU7qTh3/Y1wq6hr6o9GgXQTRnSY98gk6b0XGa58lZG63
	1Camf/EQLLcBR7nIZ1fr4LM0HTanB3mA6YkNeZKnKAfWHmSXnQ5OqmnGfrSS1Fk1GUAEeS3ZfQm
	LY9DJgIVOZelbRyRKPHHSI9lawjvhYUcS7Fd747ODpm1rbTlG5Bvna8IrQ3GAEQ11oFp1fps785
	IBTxPkGw9606+yH8HGYUcDCd98UQU898ac05Gxtp6NwcFydEJJMyG8cDi7snsBlQtJbMxogLDu0
	ejt6ve+nQtIbgsPH5x/pHiO/2B5BLg9G+5LIukOvrC9g7UqvfugO/uPSNUeuSL6/xvP0sXv1
X-Received: by 2002:a05:6000:2510:b0:435:a3c5:a526 with SMTP id
 ffacd0b85a97d-435b9306f93mr3153762f8f.14.1769186289815; Fri, 23 Jan 2026
 08:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260123084248.259278-1-changwoo@igalia.com> <20260123084248.259278-2-changwoo@igalia.com>
In-Reply-To: <20260123084248.259278-2-changwoo@igalia.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jan 2026 08:37:57 -0800
X-Gm-Features: AZwV_Qj09XJMcjRsVhLeepl5jIwtRCuMSfLzrScea9MIVqBh8kGfGuH7SfaIFuw
Message-ID: <CAADnVQJTaYo0=aaTii6n+yXLuacLcc9XSj=PLgbq+-mn5Num9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Introduce execution context
 detection kfuncs
To: Changwoo Min <changwoo@igalia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-dev@igalia.com, 
	bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 12:43=E2=80=AFAM Changwoo Min <changwoo@igalia.com>=
 wrote:
>
> Introduce bpf_in_nmi(), bpf_in_hardirq(), bpf_in_serving_softirq(), and
> bpf_in_task() kfuncs to allow BPF programs to query the current execution
> context.
>
> While BPF programs can sometimes infer context based on the attach point,
> certain programs (such as those in sched_ext) may be called from multiple
> contexts. These kfuncs provide a reliable way for logic to branch based o=
n
> whether the CPU is currently handling an interrupt or executing in task
> context.
>
> For example, this is particularly useful for sched_ext schedulers that ne=
ed
> to differentiate between task-to-task wake-ups and interrupt-to-task
> wake-ups.
>
> As the names imply, these helpers wrap the kernel's internal in_nmi(),
> in_hardirq(), in_serving_softirq(), and in_task() macros.
>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/bpf/helpers.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 637677815365..cb36bc7a80c6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4365,6 +4365,46 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf=
_dynptr *dynptr)
>         return 0;
>  }
>
> +/**
> + * bpf_in_nmi - Test if the current execution context is in NMI context.
> + *
> + * Return: true if we are in NMI context, false otherwise.
> + */
> +__bpf_kfunc bool bpf_in_nmi(void)
> +{
> +       return in_nmi();
> +}
> +
> +/**
> + * bpf_in_hardirq - Test if the current execution context is in hard IRQ=
 context.
> + *
> + * Return: true if we are in hard IRQ context, false otherwise.
> + */
> +__bpf_kfunc bool bpf_in_hardirq(void)
> +{
> +       return in_hardirq();
> +}
> +
> +/**
> + * bpf_in_serving_softirq - Test if the current execution context is in =
softirq context.
> + *
> + * Return: true if we are in softirq context, false otherwise.
> + */
> +__bpf_kfunc bool bpf_in_serving_softirq(void)
> +{
> +       return in_serving_softirq();
> +}
> +
> +/**
> + * bpf_in_task - Test if the current execution context is in task contex=
t.
> + *
> + * Return: true if we are in task context, false otherwise.
> + */
> +__bpf_kfunc bool bpf_in_task(void)
> +{
> +       return in_task();
> +}
> +

This functionality is already available.
See bpf_in_interrupt() and get_preempt_count() in bpf_experimental.h.

No need to replicate that as kfuncs.
If something can be implemented as a bpf program it should stay as
pure bpf code, since it's more flexible and faster this way.
llvm together with JITs completely inline get_preempt_count().

pw-bot: cr
