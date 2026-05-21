Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBC3815DB;
	Thu, 21 May 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381002; cv=none; b=s5DnDH3J+Hf0CTmgmsA1NcD7BsfBygF2zBmumoYN/7bLdYXd1VIaJWgk+f6Tm1qQsvgfwXKSDv552yUqjYTBFKKquyr+JlGlfbLJwiB8pk4viMO6kk5u8DPEFSF++Lwv/tfygBJQ6SdMvxJXbaDxLlXXNQupNkfwD1FMweYNPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381002; c=relaxed/simple;
	bh=S46WOv36ftn+jNBXGtGpkeNVC7WQFJQh7Z06RXezojE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=h6JTcKwf7DJam349/Dty7iGFgHnenSu+lnVslQfEoYQ6tSMa1jN4M6Xx4LjnRqidzNuVWJk0UXr/1SXR34lXt1qhNQlrelcTXDm0Zh6U4ZK4o03m9joGp64+H6Mt1EkBd5E/A1bRKjH50z58HEH3lzXVDeMpTKm8EyUbWWWsPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEMeQY/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEMeQY/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5C11F000E9;
	Thu, 21 May 2026 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779381001;
	bh=uCQ+OxNhVWY/94AhtqkKMa2GxeRjYKsB+UD3mYfJdz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kEMeQY/5vhAcl0JM8ZUlZ6IU3hlUwahMDi2JRligMZnB4ycvgX29QkUF6Fx0vlwQE
	 y2AgdOOe8PcFvF9ldoVOhg0J4PxPo7RU1JG3B7PM15x2JSQ9A6aWJWR0E7T89fgs/p
	 vcgnFR5uQzsWzCXH8MMCuISMLIo6AErlnGqYbZyLMh4Uvmbfvb78QW8Yz1aXzMp9x3
	 5G1162U7JnvXgNck7VppTdemXU9KO1hSwL6ASKp1iBT4PMK/Urasf0bJZJc/ZE099A
	 st7pBkkdFMj/PQeewcxvLtrYJIFaw8BiGpjeiOsdfyuBEaq3fIYetPmnplj11y/pz7
	 SONcBMGk2Vmrw==
Date: Thu, 21 May 2026 06:30:00 -1000
Message-ID: <4e979d6fff2f8979dad8d7a0946ce4f7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Samuele Mariotti <smariotti@disroot.org>
Cc: arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Paolo Valente <paolo.valente@unimore.it>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH V2 0/1] sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue()
In-Reply-To: <20260521105911.1814606-1-smariotti@disroot.org>
References: <20260521105911.1814606-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Samuele Mariotti (1):
>   sched_ext: Fix spurious WARN on stale ops_state in ops_dequeue()

Applied 1 to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
