Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EF34A3CC
	for <sched-ext@lists.linux.dev>; Wed, 12 Nov 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973106; cv=none; b=NJOrYdSYyn/JMZNAsWXjaOL1esyHUyoTZT2nlKpjviGFdEQKeOf4U/qbzDjUFSfUbkEe8gzFXcTp1ZQ3QV2ECTcK64+M7+9/agynBgcfko44Il/Gie2qhr1rLq1Wb6DlyVrOoJT1qrUKynqG/6iomWXju8JqCK/cWbEc20nNIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973106; c=relaxed/simple;
	bh=8FWlSOloRcwP+dQPeJvIhMU5kmDcMKTZ+qHKfJj8TU8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=GEIJbxIUXU3JoaWXqEALtQxoCp9w1ZkdmmqZBehM5hVyu487yeYwx/szMdPMlrXTwNydtMGEkerRefD1co0F9a79C4+LLjzS0hmyXP7uFcNfvXr817uqusivfS5auhACpYfM86gVsQBWLuXHMeOzNxQq9BIKC2VqXeno1Zn7Zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKZ03IKS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKZ03IKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F585C4CEF5;
	Wed, 12 Nov 2025 18:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762973104;
	bh=8FWlSOloRcwP+dQPeJvIhMU5kmDcMKTZ+qHKfJj8TU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EKZ03IKSIbln346PtO4Y6bPvbzoA+eouv+5hdhTc+sXSlbiBc6XbUxlzXE+djI270
	 YNIsKXkKojDOUToPXtGXW5IkWsC9CoWnZbOuDPBLe28Uife4bzmFktYMGK7XIatvIZ
	 tO3oDg47xMtECf/IsOcaTgdw0qyRS4HOZWfUOZ7lNbqF/Ik6ziXgZdvU5i5vFWxBHW
	 SjflbQjSEvqS75sAkIWgGKq9bIBu/WCwI9lfG0FmsdsaUp3j0C4fN9JSd/rTAJI9AQ
	 Hqu/lxKP39IG3fvsGoWt03AZC7F9PMFoFbFg6DuPbeXbvG9kqKr05UWTpo/WBZNtFH
	 NbtOmTaQUzo+g==
Date: Wed, 12 Nov 2025 08:45:03 -1000
Message-ID: <9986af755e77819615e17549118fab40@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Emil Tsalapatis <etsal@meta.com>
Cc: sched-ext@lists.linux.dev, arighi@nvidia.com, changwoo@igalia.com, void@manifault.com, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched/ext: convert scx_tasks_lock to raw spinlock
In-Reply-To: <20251112180755.1701048-1-etsal@meta.com>
References: <20251112180755.1701048-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.18-fixes with the function name adjusted to
sched_ext_free() to match the current code.

Thanks.

--
tejun
