Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5923B8BC6;
	Mon, 29 Jun 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751401; cv=none; b=QmnBZc849Ic0uoCW1kFNIxHuknpPG+Qr0fi3AFZ5iFJo1SaUemKL+J+DZfyH/jcVP3TGY0vY3sHGz+va7zNx86hrF9HIqz3igOajVk/GiiS/GDDavjWq3c0c0/C4zLE8x/35pdRU6d4933Umb56UCjZb+MkBJnAp9jc2yMrR1tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751401; c=relaxed/simple;
	bh=K7u5BWTybVat2vDLwZERE3/3ZI7WanrnH+GH3uGLRi4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=N9EEcgDdJ0l3/sm4+ZCVdl7A9yAZS08ABt1csK1SgYekqc5++hQkhaHkHiVJ2KpgHPlv69dbPFieBc1u3jcUSMbRZ4Q48SGYKc52Rqj6qQK+An/BjFYMpyZr54oK6YxdlwUEWDY0IS+CwFeoX/KTTXLyUUbQhH+H3b00qlMaFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjB+EO9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjB+EO9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED6B1F000E9;
	Mon, 29 Jun 2026 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782751400;
	bh=K7u5BWTybVat2vDLwZERE3/3ZI7WanrnH+GH3uGLRi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jjB+EO9jtR78eSgMsxnGJy6dFf4YD7MTgpLwgtEtIdgEVWqKv+jKJG/W1QTQErtO9
	 3ptPKYe1UZyqGRnoTAcwEteDQ07vQRT4ljCwC1gbWsR9f/oLHTHQR+Y4IVtU9egGw0
	 WUyvIU5humfZpOgd7xe2c2SIHaU4sWEbjTL3ES/jQh8Vqz6uNrb5hPCyVPOGbSrWaX
	 MOpvhJUvF9C1ZdjHbFBByr40mUNzKcSO5Vi0sr7qT/wAkNpIcbdaMgVVrlhvLkmPBG
	 IsmfbItzAmk0SHFAwiIAVL8HKSkDVOhbqoSvs49Fuvzac8hfYQSQJ7g1mbTuTkzJH2
	 Wx6+KO2pretMw==
Date: Mon, 29 Jun 2026 06:43:19 -1000
Message-ID: <8f08fc8378db251eba97131350553ced@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] tools/sched_ext: fix getopt() option variable signedness
In-Reply-To: <20260626095928.2912889-1-luoliang@kylinos.cn>
References: <20260626095928.2912889-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Fri, Jun 26, 2026 at 05:59:28PM +0800, Liang Luo wrote:
> Four example schedulers (scx_simple, scx_cpu0, scx_sdt, scx_userland)
> declare the variable that holds getopt()'s return value as __u32.
> getopt() returns int and uses -1 to mark end-of-options; storing that
> sentinel in an unsigned variable turns it into 0xffffffff, and the
> subsequent 'opt != -1' test only happens to keep working because both
> operands of != are promoted to the same 0xffffffff.
>
> Declare the variable as __s32 instead, matching getopt()'s actual
> contract and the style already used in scx_qmap.c (int opt) and
> scx_pair/central/flatcg.c (__s32 opt). This also silences the
> -Wsign-compare warnings emitted for the affected files.
>
> Signed-off-by: Liang Luo <luoliang@kylinos.cn>

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
