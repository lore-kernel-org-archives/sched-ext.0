Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71823A58B;
	Mon,  1 Dec 2025 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764621163; cv=none; b=h+L1UyRCPD7zWAqrgD658oPEvPdmKCwYps9RhEgXNCkNkTHKDNcS3/CH80dT2zwoMMfHjXMQO2q06GKytZCMjES0kIgVktn1l6asVAVMGlSXNVQ74cq8a2OegCg0ulZbF99nZjK4jcb/LQ9Dxw1KuZcel4EgJEf4mXLgZ7EXFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764621163; c=relaxed/simple;
	bh=ODqi/oMJYkV0WKB2oEcLWvsR3FHqftSOQGnTs+N4Qlo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=KiGXXxZFSOP3aXfxUSBgdo0n0MHoEUhLyzjTuG/vpzNIVlO1aTWCuvt6fkzMcJl6+qrUOsfyfBLu8uTpDrZ6c0NVMkXn5EDKG5Q7FAcKsnFEzPVajeJY5pFKbOCCwtPFChWNoLv+7cc+mDZesvUQ61sneOxHJMe6f344g7Fxo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IESH9wPt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IESH9wPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247D0C4CEF1;
	Mon,  1 Dec 2025 20:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764621163;
	bh=ODqi/oMJYkV0WKB2oEcLWvsR3FHqftSOQGnTs+N4Qlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IESH9wPtwvO5dEw7wo1fFwyjtneud1w1uBDO6D/QKL6sq9DApUF3NNTlu/fHPodSE
	 kJLosOUJEmQWYAEfTHIFkh7H/L0hQhG4LFyWDZ3BBJmD/tumlYl89Ge/hriDrOEtby
	 D/sn5bzYID9PnUPti2WF9fPPHCFxRevRHr7xSf9LPgoACcvNj2pfhJwB3S623d01Tn
	 0NOF44igiLJa26Oe6Fy0dHdLcVE+hFdlxQ58X/uynHZEOLixBKfDWlKIZw184Q/TDI
	 9aGMv3sGf5u2qZ8UW5CKeEf160S5iN01BXOQRpSQ7c0Ly+xTguA8G1OjjeyF1jQXUW
	 J/aomPqdp6xCg==
Date: Mon, 01 Dec 2025 10:32:42 -1000
Message-ID: <af39f843f2c9f9be8bb5d2ed244e418d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix incorrect sched_class settings for per-cpu
 migration tasks
In-Reply-To: <20251201112540.5119-1-qiang.zhang@linux.dev>
References: <20251201112540.5119-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19 with Fixes and Cc: stable tags added.

Thanks.
--
tejun
