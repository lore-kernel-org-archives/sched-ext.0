Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADB33F5BC;
	Fri, 14 Aug 2026 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786741419; cv=none; b=L4W3qK8LSSiCNXsPdatlaNBvXFseGu96w7k9NfKE4QtchZC2prZbFgc59sZkDL5R/h3XKjw2IRdXbPBtnPHOpAyKYu271WJCn8ckzNzl3NTyt0Cy8viQcAP8BzFzGqa6/qd2OKqigx9pbf0tW4U1aSi1y5FkVy9HJgtjiOiGGt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786741419; c=relaxed/simple;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SZc4B9xRx50K62Mdwj0uPPuzk1uRYUPkU9vSSTNSeVdvlCbFgl3S+SRBi/afVx6EuNrgDdN4Snyn+nxvI68AC6CRG8wlEiEOrNcukfHyySCiCEeABQiNeJ2YTemZ0sgfWKgRfSaKKOke9WXbvpXxARjRODYyxAfuAh0sc+gNj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Anc101Nj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anc101Nj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF101F000E9;
	Fri, 14 Aug 2026 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786741417;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Anc101NjIvgYGZ9Hr1VpvN4fa2vvb/dBkKzPtao/VsXJGuFL/HmgaXwRPKfNUsQr5
	 k7MElkPX7XjALbp6aZYAD49ML0Xt0wwPt+F/HfusKcXVNfylK488brUfwso73K9/xU
	 FxNPwezLeAK1UVKevok92RA4hNKcOOc9aGavfqIIZiPIsRNrYAvaajBlmAxloZ/If9
	 cNQgDWcBIAZ6svJ6TTnpj8S0AJpsNMltvjEYuZY0I1kVSYvumX8OMSdCIVqhesaD2F
	 RtTOMwZjeNcAbsfOs7624KUMygSz6KXVBpzaIUk9Rmvb+03uS0O8XHHmTZfEspQTRZ
	 +buED8//cCv6g==
Date: Fri, 14 Aug 2026 11:03:37 -1000
Message-ID: <41f4fc76b9a76e49359a0205d26565ff@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
    Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2-fixes] sched_ext: Fix scx_bpf_dsq_reenq___compat kfunc extern prototype
In-Reply-To: <20260814205955.3490381-1-tj@kernel.org>
References: <20260814205955.3490381-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
