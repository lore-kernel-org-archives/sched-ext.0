Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5623ABBE;
	Tue, 17 Feb 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771311865; cv=none; b=UdsUMNZ326d1PgRclNrRzIjH9cPigkGZI09PKRqei1qUi08Vgn4ODPFwkeH90paJmim6JshcCPsRU3ct9dt2XkgYvtDTWo1/BmwNn8iv2qnYlcuui63TFHFjCNbKcs1YvI+E3GiAlho7SqSXhgxLXfZ5v4nqfjHaGATMJr5xruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771311865; c=relaxed/simple;
	bh=4xYX/QvYV9NJUAvR1deuAt/HxkbKsHR6PzO93ebQQCo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=YtXvAJ/sgVdJaJZ4GRXmnbcmCOZZ3J8jCl5Ax1Os7KVEYwUbEClPuEJPmb6l88A6lKm5PIZGyhD9i9M0fNSDHQUuz31pb74jM+EaELPAka25oA8DtR9qFlRUZmh2um5p2rL24BHEv4LmV+tA5yAp8PHYMmfYeqYBs4wxwt63rLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LesA1bR1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LesA1bR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABAEC4CEF7;
	Tue, 17 Feb 2026 07:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771311865;
	bh=4xYX/QvYV9NJUAvR1deuAt/HxkbKsHR6PzO93ebQQCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LesA1bR1CXztfxGBvV+eRVx/0W0FmZ47j9Yr3ilZ0ypSD49iyk0Ptn69XNzrEUA77
	 9/ehoB7etOzT3zdVCbRvAyFcMN4E/RyWhelgn6nT7ziTwAtFHwqnePUGHNkiVzioP7
	 ZLrIQ60SBoA8jUjlyGrXDkVuC9bUP7Dq90rg2EJUhGhDrgsE3IpUHE1m2ZlLULsEbT
	 kjrPw6dGDh8qDrZJCcoaJQozYwiAcgDWGvEMWfho0p5hUUea4x+FIs7c8NKBLtI9Cd
	 HkhE2oCxzelvfFWJHA1ml/TgntHVbNLnz5t/Our6gOgBfY02BCwLLY9VydnYOmDTrx
	 nTm5MIkZGLlog==
Date: Mon, 16 Feb 2026 21:04:24 -1000
Message-ID: <b35c4be5ea1d9fcebee13241fee58d43@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: void@manifault.com, arighi@nvidia.com, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, emil@etsalapatis.com
Subject: Re: [PATCH] tools/sched_ext: scx_flatcg: fix heap buffer overflow
 and memory leak in fcg_read_stats
In-Reply-To: <20260214073205.14498-1-devnexen@gmail.com>
References: <20260214073205.14498-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes with the subject updated to
"tools/sched_ext: scx_flatcg: fix potential stack overflow from VLA in
fcg_read_stats" as the original code didn't involve the heap.

Thanks.

--
tejun
