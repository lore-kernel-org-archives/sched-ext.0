Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901095;
	b=l4Bt5Oa1vICW+yKJ9TD/KH6dY9WZDrfWylwD9zt7L8460/y5BbgKkHsTVTzoodtBzXT7
	 WPKnmB5FIhPB3+6HK0uX+FD4I4l25TtgfANdIVYLq/sspYnwK2fn239e0TQMQ0B5o7LuG
	 jw/Uhbnl/qjxGm/ATA5/ECtFF9yIjvq2yW7GzyrkZqF+EnQXaYunPu3yWviWlW0qipk+G
	 lzitCNCQqkwHwLZ5CDRm1bXXhM43vCLjtuY3RCuOzZoBuWH8Y7ERowC+tHBmfWYaJ59j+
	 u55TJV7isY3cZmfRHSbogDUmc9o1tTXb3wnc0lGFa1tDIXGw3Orv6DJJ40/A3r1A9vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901095;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kzCCSxGqIOflYF/5kOzEFXx9NL4cCf/soNclBud8pGk=;
	b=DEMbEcG3jYdEchR9pDsqwjNsuPG4EjR/Rrah2NugKz2fDLNOFsdRAF1YCBiG0lT9HJgC
	 41rJWiH2MeXhu+BIvd9TiO/vYu+uwU0djw7N+PrzXMElOZh9H9TYFQ1FaEXmp7ItKwJlM
	 mfElJTbApwVzDtmLvmd7IsrcjGWzlndn51F/R5zPRCCZjwGmILN9sZh7pwM0sDwL/1TQU
	 s3nhQ3vgyqxuAsJfVxfLEWUsQ3QjrMm5vDmXdM7YZ1SkZs9iXSoyM/vkEGi+4F8U2OIWz
	 tG/UHyBjxuTuDkaZC7bQ525FRX9xCnktD4kCG8ZIVIokiXjmYXUjlXkwXiNUpdQaHLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EAfvvjR7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EF606A337;
	Thu,  5 Nov 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EAfvvjR7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9331F000C1;
	Thu,  5 Nov 2026 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901095;
	bh=kzCCSxGqIOflYF/5kOzEFXx9NL4cCf/soNclBud8pGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EAfvvjR7sSPososetuksw6AjvxYXD5zK7S+XBvG3F8xIcSSIp16RPrVvl2PoUsYvQ
	 YTRtejsQqABntCbRGdIljX+/WS7gECT7qVOFwKq3KpnMHf0TqYdnCNqcGoUxyClCEo
	 vMEV6RJiIDBQz5ePshQtGl83isWxoaT+WicNXJ6abv7OWlmTFmcIB0Fs3hAZwWSZPF
	 p9l6tNw2OPa0b/B5E8sHEoDmIwm9skSOenbOY+3tZGgnT+mOjgVcOsp+UilATEtnSQ
	 dM+vQzDKaop3TR7nNLDuzWOeC3SVGG95B8RGrJvrFxgL50QcAJJGG+jSGdcbIxyjno
	 usBJuyEzwzYgA==
Date: Thu, 05 Nov 2026 07:51:34 -1000
Message-ID: <4f5f54504fb1221d07ffb6d66b9f449d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Cheng-Yang Chou <yphbchou0911@gmail.com>, Richard Cheng <icheng@nvidia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4-fixes] sched_ext: Read exit_kind before flushing in scx_flush_disable_work()
In-Reply-To: <20261104111449.3984318-1-jpiecuch@google.com>
References: <20261104111449.3984318-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.4-fixes with the following tags added:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
