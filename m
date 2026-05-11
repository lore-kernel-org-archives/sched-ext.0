Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CE242D7B;
	Mon, 11 May 2026 02:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778465060; cv=none; b=PTvGmlNDPXvQEQqo97VgOZEcSX/o4fRe5o2Bs39PgXcRbFvv48qYer5mqBB9x2ZGjywJHw7cE/7IJEvVBRQWWcV6NA6PN8GhOaJOA/uvUpQYElqYPIORTtRYUz5vQQq8DYG/KbsGcJLN25JjfniP+ha2VKcn09rGY++JjwCQYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778465060; c=relaxed/simple;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=rh22ug3mDtP2iLWsKVKSYlueGZ5SOycq895+7gIQBSgse6rtwmOF8osceDSdXYMFAK8S5JFTISA/JXC+zB6LseIxqx1qW50mX5SgMZE1jCLxffnC9kM3Hruqd8QLeNWxs61JdWtzXBIu4+gn6ylb30TSdtox8T969ANEg5rnVWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFozasNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFozasNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B1CC2BCB8;
	Mon, 11 May 2026 02:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778465059;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFozasNvzwmwCO0KsSzUlNdDKLrU9TE5/s6MoxFtFfuzG4ZyC1GVazW9fP8Mj6dpU
	 a7QOk5hAf38+mvImVH1vFU2Wem0qboudyMo5EhaVQ39KSTsTDNrW8EqVsGbCMSUjWb
	 guexn0TIzvUyKzt8qdMWsGh7x8P2nxVX1X3X/60UJb1wOQneN4mzfVCKr+j6e7w6+9
	 BHsNUz2WskPajOEcmrFKCNoDwAgYrJEENsBO0Bayvyh0DktW+hknvZZfM+qe+eCfjO
	 XgcpVSwDqBFxr+fLYraMYAqHgfLOGgdYNfn0lttpyVkUdQJIL/6jt2C1wXUKatUVFI
	 6b7gGXnQXgR4Q==
Date: Sun, 10 May 2026 16:04:18 -1000
Message-ID: <1d6dca464a0b5de7cf120328bb847473@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] selftests/sched_ext: Fix build
 error in dequeue selftest
In-Reply-To: <20260510175211.978332-1-arighi@nvidia.com>
References: <20260510175211.978332-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
