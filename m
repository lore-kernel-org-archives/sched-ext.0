Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27F280A21;
	Tue, 17 Mar 2026 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770054; cv=none; b=gTcCr229AfgJwMLSlVz9XZR9Zr6eRzAVAr76Cl3Y7rDhStvFAkSd7XDNfWxbo6QQRuwsB+11iHj1ByDqLUcpz4K+PpOi1SK+TYlqEB2mMZPqiAx+GpF5Rs44VylJTyXWy1hjgZVnDH8JWdCtgc38a5mlsMzJHtcrvTLJ3gb54+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770054; c=relaxed/simple;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=pfAr0vHH/EtN1wIVb76/ztOZMe8RWttMDyzn5kJqW0P5C/qYHpc2BLRzdwUU5ZTuQFqH4GON9fLWhRiAPKzuMQQtt8e2ArOV61WAwC3X65h0g0zXUtI+DItzJoz/yqxTwoBimj6j8qc8CReWs/d0XfN5PCBS2YcguaPs9Ow7r1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFnTFJ9Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFnTFJ9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B896C4CEF7;
	Tue, 17 Mar 2026 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770053;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GFnTFJ9QAepAzZ8oxRr76IFc/HjV/jfbhbtdDP5TT+6wj5E7FkBStDWKuX+cv/V9a
	 VF/l0QwzJ6a0aW/bel5QCQiYXuufaake7kNw0c/ovV6czmNpSSuMqYU5f7IU6PsyBx
	 xzqGmpm3HVnnYRmOJ3qVOBW+rQdmHRBM9i4atONRXxIKPRdqbeEZ1/3zZHpiN1ph2M
	 otU8u6CWPbvZASC5b9tb+12vH9aq7+O0V8mR+KKfZD+1/cEdW6J4n18bQG5rRmkKYp
	 F7FsR6akiRYdda5kx4UqmWodeoGyFZkQM+dDj8CGV/5WYFfVUdQCBkTVC6TMe52WRq
	 nDuJu9dl/O3Tg==
Date: Tue, 17 Mar 2026 07:54:12 -1000
Message-ID: <d9a7272d7410a5f86adf22f3bd60cb5c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] selftests/sched_ext: Show failed
 test names in summary
In-Reply-To: <20260317151406.937519-1-yphbchou0911@gmail.com>
References: <20260317151406.937519-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
