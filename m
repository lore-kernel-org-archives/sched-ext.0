Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74252455188;
	Mon, 17 Aug 2026 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988487; cv=none; b=TMjeYv3oFT+CLhPY0ZgThIsjC3OEmy6yGbhBl52f5Lg0uN6a3Ueyoc7oHb8g2NT/8s7DaZ8TxziF9yPe1kebjPZaPG87+hN6fTfPO6U4fg02xxndTRQOwLgiXJpnqpF3qbflwDaYQ1uk2TOm5+MdoR+UG7vVpz1VZQNiHMTHzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988487; c=relaxed/simple;
	bh=7yeWw2zXyEG0tODZWK9SsXNdiBcvkOclrb/jtHmlrRw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gf2QpHlFEyixe3CRUVcOSyjIVLz+ULeRSiaam/56IomTa0ix+3M58Q/kQGp09WHKNNQ+XbOsphf+xI7H5A3W7I01v5DMRkyplK0gi4bmDW88d22CDEg/QTjK42oxHy+/CL/u8A9cZ7C8Mzn59mgD2MvJh0LaELGOrxHhtU4+6M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJO2oxJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJO2oxJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B8D1F00A3A;
	Mon, 17 Aug 2026 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786988486;
	bh=ki3SdavbXVu2S36LuMlaKGmxafr/9mWn/JBzv9KmTCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PJO2oxJTtHNJhJlAjUumELxA+ZGASjEeA+rMjOrgyRcHwaAjpBTldYF45yz6l9uGI
	 06WxzjQjTD5YrPxwDTYmWZPpboEE9LeT7+y1sKmVCf3Gvp04baDV0gPedZJXuGeIOv
	 yXTh1atGe6G4UI/d9StOUCqERcD27HYvEAu98eGLKJ+YOt0qI1H5M1ZHutyH6Nfx8W
	 iS/JNRCZcyag39+rMrP5J/pj1SF/+sxQlHcBymKgj/Z09076EAuwcSxMk3zAwCNbIq
	 w95qBqP3DMvZRSg9gYd57h6m4EbUOUfkGAoImofhgkF5GiqlFDeRstHiuafPw7Ww0j
	 fWfavj01+XPog==
Date: Mon, 17 Aug 2026 07:41:25 -1000
Message-ID: <44199d9d01b3cc6fe3b07f57501e7e42@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Gavin Guo <gavinguo@igalia.com>,
	kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] compat.bpf.h: add scx_bpf_reenqueue_local_from_anywhere() compat helper
In-Reply-To: <20260817143126.562923-3-changwoo@igalia.com>
References: <20260817143126.562923-1-changwoo@igalia.com> <20260817143126.562923-3-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Changwoo.

On Mon, Aug 17, 2026 at 11:31:26PM +0900, Changwoo Min wrote:
> +	if (__COMPAT_scx_bpf_reenqueue_local_from_anywhere()) {
> +		scx_bpf_reenqueue_local___v2___compat();
> +		return 0;
> +	}
> +	return -ENOTSUP;

ENOTSUP is glibc-only. The BPF side picks up errno constants through
asm-generic/errno.h (see common.bpf.h), which only defines EOPNOTSUPP,
and as static inline bodies are checked in every TU whether called or
not, this breaks the BPF build for every scheduler. Use -EOPNOTSUPP like
__COMPAT_bpf_cpumask_populate() in the same file and update the
description accordingly. The pending scx-side PR needs the same fix.

The rest of the patch looks good to me.

Thanks.

--
tejun
