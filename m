Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402A2D739B;
	Fri,  8 May 2026 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255147; cv=none; b=T6+anyfNLgyHcJ2xsodXR4eVrdOsuTYhNdbnjWsxIdf6AKMHfEEfPnTPnIdC8FGb3AKqOZ3jVILokFUE7GLqbK8OMEavbj5+2RqbfvZ9R6jMbwPzmZN5IZDnHSsBlyq+9zHcaTLjOFS4zGgtXqRY9FRQbnAF43tL3oQQ5uGMj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255147; c=relaxed/simple;
	bh=DHaxWuE3L2i2g7dI9xnzL/k+kS5yVas41hw24DlmxsI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=leVGXtjtkGHg0lvZVa0Y0o9imFLjxp/fn0jU6yoYBE4fF+SYF9eIrdJAwmTPXgnQP2zpVHrXRsl2r3Jn2VSw2JQo0FbXYcI4sS6MhZQBCaa8+Dp1/3ok3NCOHGmHqfprL/292LS3v1i9UR+2ZozjYZuVebctKg1MoM5EUheNsKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO2r+hzm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO2r+hzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44325C2BCB0;
	Fri,  8 May 2026 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778255147;
	bh=DHaxWuE3L2i2g7dI9xnzL/k+kS5yVas41hw24DlmxsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GO2r+hzmPLawhEhFLLtuRGAmCRbvCKH4QqpN/im9DsilR0106tBEKz7/Gcdvib+2g
	 mM1b0ifGEGgjn8iX8movI+c860Kzpr8oGgJ2A4wOBr79eI6ZAFpmmubXOjgOp5hgfe
	 /4jmm/VB/zKjTrAWAWuqwrXwNDHGDL2s86tcaBJjzCmgfnYpu/esilB5hyYwLKM3XX
	 3JvQt+sHbPCz5Z2JbBf4P94zH5AgI7vyDMC7i1VizJszqToKXVtqrR/aamfNKK2GCy
	 C5G2v6HWRVv0TU/Mj7lCPPXkNy+Oj5XjXmSXqu65NwkxOIB68Fvclux/nqKYXj0XHF
	 +ZQa5vuYbxqMQ==
Date: Fri, 08 May 2026 05:45:46 -1000
Message-ID: <ec8ba2efb759e6d9d76344cacbc65ea8@kernel.org>
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
Subject: Re: [PATCH sched_ext/for-7.2] selftests/sched_ext: Fix select_cpu_dfl link leak on early return
In-Reply-To: <20260508065514.1723906-1-yphbchou0911@gmail.com>
References: <20260508065514.1723906-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Fri, May 08, 2026 at 02:55:12PM +0800, Cheng-Yang Chou wrote:
> selftests/sched_ext: Fix select_cpu_dfl link leak on early return

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
