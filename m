Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED52C187;
	Fri, 27 Feb 2026 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219942; cv=none; b=Sv4q8b2hgUk6sVvMCviqItX0+fzmDbkK8rtaQGx7BhV3nbqA9aqD6XlW8BGt6vJhXw/VuCew2NkT/ir1+jAO8BkrwAgsaFMca75HL3rM/7pjjjybicijNzItCAGwp/m6JIGROYsP5iP89EPd8Wem1dU7QSulv6IjTXGLWLJ8YQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219942; c=relaxed/simple;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=H6DPnphLUy9pREeEW8A3/6Uc6kNxIhI7PWIAuyPctthc0eLZbJtENYveRthMcmrq8ASvF3z7rYk3wGsNPIkEowRqXr65xLxgvIDsnZMuJGik2j7NMbgWEI5VbLlVlzlQei6qJFyUijaxcbujEVHO+NX8aAuoChkHFhZx7ovm6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCX+bR8J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCX+bR8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088F6C116C6;
	Fri, 27 Feb 2026 19:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772219942;
	bh=JT+RFfTayO5DShJukirFxUaq0lwtYyL+1kZfRbdneeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oCX+bR8J0FUbbEIFiwtKIdx+E/+iUF3TQbMvX1/ficcKyzcygWH/Yc2WS2SXy7t12
	 O4eWHawKo5L6SKqwsqSmy+O3UNBEoyof5IKdj2XiMwk9PDd6KCnE2fAm4sP8x7i00Y
	 LJthp6HkeByi3KYypGjjaAa4I+KU72+uXJzWmVEkC0wG8EqKHF3W9oyaMaadfjmtD4
	 z63ji7km8GQ7Kra+eEeX5tv8lFpEvBAyKEVuAwi7nOadjlph/1iWFtj8VzWAZpZh2D
	 ps/5FYivqrZMKFOocm0s6Q37x7rH0NMrJtBMYvSGUfXjurPQnkbTMojrohuutV/VM9
	 PpofRuS0Nj5gA==
Date: Fri, 27 Feb 2026 09:19:01 -1000
Message-ID: <b35762b08ba106938b05c1541677ab2c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>,
 David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] tools/sched_ext: fix strtoul() misuse in
 scx_hotplug_seq()
In-Reply-To: <20260227184309.13183-1-devnexen@gmail.com>
References: <20260227184309.13183-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
