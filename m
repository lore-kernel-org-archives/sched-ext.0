Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701952E762C
	for <sched-ext@lists.linux.dev>; Fri,  8 May 2026 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277131; cv=none; b=SIQ2zwWhblOrZy4y90TiPYr0TZDXGHAlYIxTuLKqy5+N/bmiZl1izQ1dUOtPE73RXWU6fp0fF8YNGoEwXAczudm05Mjxdqvy5Mk/fRgEv7qz3arzLJXNZdrfUXXPTonTOBi9ozOWNPRqMEWyPJrq017x+dw9Wkw+mmLYDb36i2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277131; c=relaxed/simple;
	bh=v3ARb5uVf2+Ddb8FiAwpvjPKA3XutkuUynRQk1qRKn4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kSad3EL2/t6IeCpCGbPxZ2PCnrr5xR84VVPeXM5tz9rczE9bFxhKofA/63u0k9c76DWlGLxgpDbccokA4bzRrRMh+KLRhLu2xTYb41p49TV3z2NvYAZgMdhAHc9ZuwrGxPRSwY+M8XnxXGmi2Q7ju8iPRZrPSK47E1G2gg6RDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9kCIYMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9kCIYMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C03AC2BCB0;
	Fri,  8 May 2026 21:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277131;
	bh=v3ARb5uVf2+Ddb8FiAwpvjPKA3XutkuUynRQk1qRKn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=R9kCIYMFYT3m+lKD0jfKIbJdVSY1ZpsYx9yeyVn+kw1PJJP7bvhjPlrw3cn5hiGD5
	 MXm6S8ZVQthT/6wRa9CQ4wuLN1ajG7aIdZN5c+Sus1Bnp6RZqaPaXRHlj/Q+9inDnV
	 a40UQXX6n43M28c0xGj7QeCmHkR73403qMotyVQkPy6O6eoQTZ2vPZcx/zXPNY2jGD
	 mDM5HgsES6Pj1ri4QvxWDVxeewYQg9oGzhUr0kyKT8sDG8G8fdb2ku8LdS5iB+9LlE
	 DCumvJiSn7OgDbYycHnOXgqa0k/1Jz36flRAXXm5u0LODVGp9q+Z43daF07qoVHmHK
	 10ejqGgZFjYSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND sched_ext/for-7.2] sched_ext: Use offsetofend on
 both sides of the ops_cid layout assert
Reply-To: sashiko@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260508160651.4030241-1-tj@kernel.org>
References: <20260508160651.4030241-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:52:10 +0000
Message-Id: <20260508215211.0C03AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The modified BUILD_BUG_ON assertion is tautological and no longe=
r enforces the requirement that sched_ext_ops_cid ends exactly at @priv.
--

commit 5445ec05ee0d3c461f6dab131ab56481c5c2fc81
Author: Tejun Heo <tj@kernel.org>

sched_ext: Use offsetofend on both sides of the ops_cid layout assert

This commit modifies the layout assertion for sched_ext_ops_cid to use
offsetofend() instead of sizeof(). This change was made to avoid build
failures caused by trailing struct padding on 32-bit PPC architectures.

Closes: https://lore.kernel.org/oe-kbuild-all/202605081637.DbH4SZ1E-lkp@int=
el.com/
Fixes: 7e655ed7b953 ("sched_ext: Add bpf_sched_ext_ops_cid struct_ops type")

> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 1d7f206941f0c..5eece6c95cf5a 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -10451,9 +10451,11 @@ static int __init scx_init(void)
>  	/*
>  	 * cid-form must end exactly at @priv - validate_ops() skips
>  	 * cpu_acquire/cpu_release for cid-form because reading those fields
> -	 * past the BPF allocation would be UB.
> +	 * past the BPF allocation would be UB. offsetofend() on both sides
> +	 * instead of sizeof() on sched_ext_ops_cid to sidestep trailing
> +	 * struct padding (e.g. 32-bit PPC tail-pads ops_cid past @priv).
>  	 */
> -	BUILD_BUG_ON(sizeof(struct sched_ext_ops_cid) !=3D
> +	BUILD_BUG_ON(offsetofend(struct sched_ext_ops_cid, priv) !=3D
>  		     offsetofend(struct sched_ext_ops, priv));

Does this modification inadvertently make the assertion a tautology?

The preceding CID_OFFSET_MATCH(priv, priv) already enforces that the offset
of the priv field is identical in both structures. Because offsetofend()
is defined as offsetof() plus sizeof_field(), and the type of priv is the
same in both structures, this BUILD_BUG_ON() check will always evaluate
to false.

If a new field were accidentally added to sched_ext_ops_cid after priv,
would this check fail to catch it since it no longer evaluates the overall
size of the structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508160651.4030=
241-1-tj@kernel.org?part=3D1
