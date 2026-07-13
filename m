Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FD34E763;
	Mon, 13 Jul 2026 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967730; cv=none; b=ldldb0f7jx0ggU+hbZ4S0XpETKVYwFbkAXAFB9dk4Dk5jtDUmVQHsrzgxojFh6cozT7oXEnNGI7QjCCluXElHR2nZXApEVaa71uHDlEFE1cdp0rfhmmjXRPUg33eZ63DGzMyPDTL65toyZaU87nfX97tF2/TjrXoTW8meBmv+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967730; c=relaxed/simple;
	bh=29zxGw+8Ba4AVHWvwlZS7AlYmm8f+Pmujj1mrDJsY7A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Atj1G4OJRxvX+ZyOICa50d1bgiUZYL+ph15pNYFsOKtRr432gGcV683f3wEb6u68KDnUWGzcTH93xUdMCB5xaALlaymDComAqO8Ol3dfIvS4iSXAyASsDwM6KkXsPK62cAoExA47QKgMbi3e8C/EvVXKqCuBgqXqerUISImFIKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx/oii6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx/oii6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F2B1F000E9;
	Mon, 13 Jul 2026 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783967729;
	bh=29zxGw+8Ba4AVHWvwlZS7AlYmm8f+Pmujj1mrDJsY7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zx/oii6SjwHpOTVtS1Z7AeZyh0476pG9iY8g40XoN74DOBE9+wPTzWRd+e88BlqEO
	 KVUXZIu2s3R/CQYkpR/J7Hk92bzfD4Dbo7900p8lTFBjigphlcBdPHhJpYcQhGvl+U
	 zqvuRhfTiOyZMjIB8HvksG+mjpueTJKxLJBof6doQTuXsO/DroI3M4g3Qv2ij1DR37
	 bQcn2BEWi8eezYN/nFfZhup3gPvWWpZI4pugSeKLRX+F2PDLzderF4cwixaG4Ta7+l
	 JIcHR638XM5oaiYmqsvNkQZ/eecprdBPoVZDX3Xgc/fqWL9kklDBWNHVjNlhf2bNQl
	 yNXWIhPEoFRjg==
Date: Mon, 13 Jul 2026 08:35:28 -1000
Message-ID: <9e8d25c2575cafeaaa0801f9808238d5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: scx_flatcg: Fix uninitialized stats on allocation failure
In-Reply-To: <20260713071808.89847-1-luoliang@kylinos.cn>
References: <20260713071808.89847-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Liang.

Applied to sched_ext/for-7.3.

Thanks.
--
tejun
