Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DB40DFB2;
	Sat, 25 Apr 2026 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076598; cv=none; b=bKWrgWxY1m5hQfj0BmNyVQ8YAAVlxGEujf8tIs/SOlWu2EwwFIG5RUQ3WJxVPpd9+sideLTkNkARHwOLcKstdXO97MSKbIwleuWmUsLsQKmOGViGL6f50NpzBa4DHpMqZEEBtwzbFJptpzlTlIeWB29DNXaP8zmnxHhsfgHZFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076598; c=relaxed/simple;
	bh=IPPwj3wGXdJNgfx7ZyCXQjYbRHxs0hDZtPrw+qX1wfc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=RYMv98LF5yX+Ln20kCrSwegVl/ne/6/VNZp/UVsk2LhGsH5DwNHNuRUZ9DC6rvvh5Bw1VFGMyO0c9iUxTxvuBTdCREq32oQ+c29eKAH9PBfJKbDa2srOQbNrH6zuFgYzRh2Xr6hZgjmRJc98YmyXIpo6UJw71l9TRsAH4AyQhj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1LrprL3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1LrprL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90325C19425;
	Sat, 25 Apr 2026 00:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777076597;
	bh=IPPwj3wGXdJNgfx7ZyCXQjYbRHxs0hDZtPrw+qX1wfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n1LrprL3sNRFcJmEdLGAwXrXXDEwkKrvqON8JN2uYYksmzwK9m4KL5uCyAsmFn9dM
	 1TZy3G/KWYr+6Z/6wQmqIk2bjq5B9ExnDzr2SNoTpGVz/SzF2aNGvC9srviXw6R6uk
	 9fXSoGqD2gEWcWEavcjJ8gc3YBXKHrFv+epWmg5uq9L0k/O0tyURAU7Z2NCxZGRIb6
	 8miKDfm1iKa4GroSwD2SumLQGcaBOWuzPF1PXuNMDUTXLXMjN9m7c8GLimpccbr8w2
	 4vnPj7Yh8RZ+rd2ZpYyRn4w4FH1h+U0qRopFvYpnseEyKej+sOQjx36yEwyzlQ8bYA
	 9GfbQrhbZaWFQ==
Date: Fri, 24 Apr 2026 14:23:16 -1000
Message-ID: <32173da2e3d3bb3107d92ade0c4c87a0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Defer scx_hardlockup() out of NMI
In-Reply-To: <e78c625bf7ef51fef0e564d9c25482aa@kernel.org>
References: <e78c625bf7ef51fef0e564d9c25482aa@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> [PATCH sched_ext/for-7.1-fixes] sched_ext: Defer scx_hardlockup() out of NMI

Applied to sched_ext/for-7.1-fixes with the Cc: stable line dropped.

Thanks.

-- 
tejun
