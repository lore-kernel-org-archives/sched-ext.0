Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC222EACEF;
	Wed, 29 Oct 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751079; cv=none; b=XNL8X8lyEm2QdWkNg01EihAPl01XomsF6Pr8Yu/97jE+hCW+hoG3hteNgyA4NVHGOcEjfevK/6VHOrb3vA4psav94S1qnjrt2fAFX9EIvakzKYivDCHo3PN/WJgeZ0r4S0XtKLx5uZlQJfA9A5Oz2796ZF0uC3b250xWP6ymYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751079; c=relaxed/simple;
	bh=NBplsh0624Kjxvu8SMTCt/4O0tSu1lpyz5XBuZRcxiM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=axq70+bKz8/+9gfPJ8nieUmxrL0rhGDLoidc1iEVBO3kudceleZJxaJeeL6y/l7lQBRsdmVSNMbConM4jfUFnj5fgX7LYa/uXNd/hH6iSFYRp7KS/1034x/oZVuS0tNf1SSn3cqr09idbhnLqeHN1bEuX8rQMybYLUImyuSU8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur8FnqCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur8FnqCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E78C4CEF7;
	Wed, 29 Oct 2025 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761751079;
	bh=NBplsh0624Kjxvu8SMTCt/4O0tSu1lpyz5XBuZRcxiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ur8FnqCq0CjwrLe/LcyWc/TRd6Mkncb68Hpab4J7TUZD5gvWcpizExR/N1r2WuoDC
	 SmYA5F7bFFJvUPZNZdU5qAqCKdHb18PocB0z668BbhwG2wvuc+6tLS4cfddZQLrY42
	 jY0fzl1E87OSzOlpqRpzWhCp1OG5JdyP0ZS4qoFtyDNmP88LYLlkybWpzdVdnM7hHO
	 LUfaDqiYh1F5JPxDewNs2PCsXZ1sFbWTHHVDw33G7/PGWCxOttGcdiSkSrLaLrSH3n
	 0iui8pt19b5mbEpzwF3n8cteo1OoU0fthDYIVteNiSuZgLnFd7a7ozY9zh5JmJpVRb
	 G3ULmvhscCL8w==
Date: Wed, 29 Oct 2025 05:17:57 -1000
Message-ID: <a69e7bb7f33a8e44664b366b03061f4d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix use of uninitialized variable in scx_bpf_cpuperf_set()
In-Reply-To: <20251029130843.2977395-1-arighi@nvidia.com>
References: <20251029130843.2977395-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.18-fixes.

Thanks.
--
tejun
