Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409F3C6611
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288443; cv=none; b=dOSDJ+t+GZRUGVKYzHbtOJLyU6UDDp2ffjFqcTRcFjCuHOfhSGF3JzAdlcTa4V1hnXgDikY4QwuqpfGfuY+Xcn4PoQI31ez/xI/no4JOZgMObviOVpIGNFJWWlBjqg9o+8E/iYsBlMV7dKlO4AIXNrC1OjxMsBhlBpoUvlzOwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288443; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=C43czoFMjgmDgS8PiCL8yMplUqMDPW7A1PznzlE3Z4J36i1NUCUJn0J4ZpyZ8X5HvNRXJ0zfEKBeQ47HuK2SQ7ypM/yHxngwNdm1wyWukWhlWDJ1E16Ffk77b6avci0FhN+P0h850khddYAysbhEoTYTOq9BKXD8Or4EfoMxgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhEV+P5u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhEV+P5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EADC4CEF7;
	Mon, 23 Mar 2026 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774288442;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BhEV+P5uZ0xABbl0nTxma62ZxKFQrXPtOuKSl41bp9EjR7NbJHPyuoUKIbDkpQPzx
	 19d0s+syXJ3GWRDOnPwH0arMfx41jLwBS/bGkp+JWalPEMDD/VX0WpoVcr8q9aB11s
	 60ot+jcPF7i1HHMaFUXXqoohaImsfFMllThYTSzbWbLU0TSgVXZxGGipK9D8Ojw9HW
	 N+X+ljXL1Vo39K/q5+VEJTbP9qrACze1qxK/aogxfDQMFC+OdZgruYuXeatr7RCIeR
	 CkwKBa3BI5fTXlOCAx0pBpPniMeZuy5H7Vsuapueyv62qD5hObEIgx9uHf2E8a0Z+9
	 +nNQpnnBg2pcQ==
Date: Mon, 23 Mar 2026 07:54:01 -1000
Message-ID: <8233068b2f1e8bed02bc9affb7618f3f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Fix invalid kobj cast
 in scx_uevent()
In-Reply-To: <20260323104848.3879920-1-yphbchou0911@gmail.com>
References: <20260323104848.3879920-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
