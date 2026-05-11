Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43D383C60;
	Mon, 11 May 2026 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528041; cv=none; b=TrE0cQgMk55YKERn/y+g+lNNY93i+VhY0WRBHFGJxtKqyd0REKkVKWEgxmTdLLhzovuwhduKJXE2SfYgoqP1gk5YJFD4RQ07TpqeKAHPby2mpvRwOjPM3zA1z/JzRv6ygNA959spy6sULHuNkOEhKXxl84mkpVOlEqxJsOvdbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528041; c=relaxed/simple;
	bh=hmwsQqVjMHB55wOsumO5thxvAT8dwx6vulPlRfnfa+A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cab6gfmGknYWI52AHxe651tZaLV0vftKZSkg2EHbxBXiPRiE602uIiiiJBC5NSUalPK8Br8znW1GVKFrXWm5a5zuD9a+k46lTq95nbJS23vj3frQidv1ShonapA9y9iO0+v3hnouRYoPD8m+Anzu2TIx7GN0f8dgYdLyoX1f/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovw1xlIe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovw1xlIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A00C2BCB0;
	Mon, 11 May 2026 19:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778528041;
	bh=hmwsQqVjMHB55wOsumO5thxvAT8dwx6vulPlRfnfa+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ovw1xlIeasFmwU10a+wUmMFRgr7Mvslnos5i2rbJOAShzlWXCCK9t7ASG+OpwteJ8
	 GydeibMTgzP3IU9/pVGdmL6uZxdze0nEMJqrjtK6xH8tLCpdOr0yJsz6dEd2m1OrJv
	 H/bwWigefty1UxEY6bx6t97K+YTSorSaflWACe36l+isDDRjjhOky6UMj0hUxl4VxU
	 c/SgaG89rak56knFL9ssUrM7UpvLj4mz77/7exLkPxjhJvKbABTFCzl6cTYa/fZAdo
	 OgEy8YE6smnrHy0b83+8cN4brrbecanC52FFRfogSFG6oVGDmd7cupAvKvjW3WoGES
	 zg+SYkqUpYXVA==
Date: Mon, 11 May 2026 09:34:00 -1000
Message-ID: <3c712eb5dd6087ecaf154b95f71bf1cb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Replace tryget_task_struct() with get_task_struct()
In-Reply-To: <20260511191940.119539-1-arighi@nvidia.com>
References: <20260511191940.119539-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Mon, May 11, 2026 at 09:19:40PM +0200, Andrea Righi wrote:
> The tryget_task_struct() calls in scx_sub_disable(),
> scx_root_enable_workfn() and scx_sub_enable_workfn() can never fail at
> the points they're invoked:

Applied to sched_ext/for-7.2. Fixed the cited SHA in the description -
the analogous earlier change is b7d4b28db7da, not 54d1429e7180.

Thanks.

--
tejun
