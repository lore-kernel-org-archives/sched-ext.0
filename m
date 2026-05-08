Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D93ED5A1;
	Fri,  8 May 2026 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256830; cv=none; b=f6LhVOm0ncHGT7tz3Qh4bXnfOflKU5+tPEnDINtuSHoTFZbBUj9C3erqe1Fg0Q4t1lu/0NryBKpVWVP3RjgPX6DlU2cgikVdvCStthEIqrS8cUfw0v3JDh3JcDU6tIMKJFMeboK0lemZuLuJAIgWba8yreOwMsaSBohhir3OJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256830; c=relaxed/simple;
	bh=qwdHNsm339DgGlPwlYlDBmESvB43wCN5K9Fa8rDpWmI=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=RgFkPDMg0b87FMPpZr/VMw0vngUTdu5QqF0mTwIJixliR4aGiYx3lWLmp8jD2/0Wy0FeMUOUO5Fzm8GBasMWt23qhVPIcfwcwAXRVZ0SxKeiSNiBgiRmZ9f+a0trHYIQ9pCR8ump7sBPNPQ82ljZ+E2evYHlJxEzNXGJX13VA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArYsa4XI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArYsa4XI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2C2C2BCB0;
	Fri,  8 May 2026 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778256829;
	bh=qwdHNsm339DgGlPwlYlDBmESvB43wCN5K9Fa8rDpWmI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ArYsa4XID28C9SHzERn+p6PL49q1mzKvydsVJn0YivKGD9WcWQ1wZzRrYO8MjfiJ/
	 QC+sezX1mAa+vCIsvdZemD01Aq7kbL6WPAe8ZZaxhMKWcUdQ/VvcoylYui4mUm7Peq
	 6iJptjiHTAZWWikzxc+1F2JWsNN7EoTFhtVNVygKKNDAYLU0YV8rbY29kIrnXA940l
	 lU0E/SMb8sZMTYRJmYQIzV4y7O5iReeLMI/Q9WitKgys4P+8u+BdTI962UQk1Bx8yk
	 QXM/57XK9uZv8eoLMp5ZxjY4+UyJBidN6hNU0e8O4uqNnbzkEoibAz/e7zf6G1C01s
	 8Gi3tLW5Q654g==
Date: Fri, 08 May 2026 06:13:48 -1000
Message-ID: <9a54a92413100ec457f855642d810745@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260508160651.4030241-1-tj@kernel.org>
References: <20260508160651.4030241-1-tj@kernel.org>
Subject: Re: [PATCH RESEND sched_ext/for-7.2] sched_ext: Use offsetofend on both sides of the ops_cid layout assert
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
