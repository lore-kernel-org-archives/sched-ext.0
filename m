Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8F239099;
	Sat,  7 Mar 2026 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772907142; cv=none; b=bMKQUO08qlY6dw07uHv9u0USgQg4Hhp37hx7s4GKx4Z0FNuh8UAG0m/HzRbVype74MLHgHQWuU9GoDyXRfMooDAGe2uC8Ri91LCQeH7prY2iJCe4W8DW035Im/0O4iE7HzYspSkC/W4V0Qo6V06Tf9hQj2tV+MgdcXg8dYgNO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772907142; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLlKpJtFE9s5pWbCXEQX2VykZSJvJatAlBfDQWS667zenBK0rIz+v++EG7JbGTHaq+2vyaPIXi0YgYM6R8NFNKV/DxQuF6Tj2VTk+x+AM4GmyX29bRDoXvXe3EYA63vcOaOJI0CGSCCEF9f3ZW16dSjs7ta8T5dVllbRqwq6fcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAmxKcOf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAmxKcOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2759C19422;
	Sat,  7 Mar 2026 18:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772907141;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dAmxKcOfiGs38Nye7ftW1xA5SlRehvowsZ66irUpDzNjdUkd2JA3WmJ4fpHIijiDo
	 ZixxFh7XFX6r1Ya5lz1l2/X9VFu9SpGoO5b+3JgKsPXdHXUs/os+M97dQ3dOLXBBaU
	 ZN8kFXBCleVHZe4lvU5tIiQhBhi2uk5kkxs8tHXZ1ya9Ijk1v3QSnz+eXDRHmps633
	 DEq2myM3XtfK56JKwgGB28kQq7p9R117ByNoBHIqa+9AiMSu11dKWmpF9zVa+H6HjB
	 Ab6ZEyVRzwyzz8vJr1tIoUB01L6rP00yX1dDStBqWPzralv+OqmvUP+Lwu5ujVNhgG
	 q+F9dBYqDwsqQ==
Date: Sat, 07 Mar 2026 08:12:20 -1000
Message-ID: <fb42880e59b5d0851dc1ce7b52cac3ef@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix scx_bpf_reenqueue_local() silently
 reenqueuing nothing
In-Reply-To: <20260307172628.4112680-1-yphbchou0911@gmail.com>
References: <20260307172628.4112680-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
