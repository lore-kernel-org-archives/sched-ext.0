Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686123A5437
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381253; cv=none; b=Jh1drrdhDgC91AIf2IPjQJW5CbHPntqAMeXAjMGmqrc/wCIFVlQo6BhO5zosws6YDtvyI/FPPqfNumQgPzET1vVm1AqHg41yor3RsmDIwdoCV5bkUi4VJeC0PCLXewyIqwbnlQueZOyYSjjkuXoRcGUBN3dcuno8XAc2lI3yC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381253; c=relaxed/simple;
	bh=BahS1II6hs3INvMWqPxzPoNYuFi5J+d6Vaz1dtqd9ps=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=L4/W2ot7HGMLVDKDyFCbc3cZI6kU5L7Dcka3Zq9ewQBfX5Hm0tBOo+mSEl205PR19/3XM92B1QKW5PBolSIC7b6p5sn55UfoLwqZYV/P89xCW+FRudJu1vgjUwg9CtY+Me+rZaYvVfWMBjUsTMYZVxYZtqfluctlqefXt9Ft80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLyFsQtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLyFsQtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76001F000E9;
	Mon,  6 Jul 2026 23:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381252;
	bh=BahS1II6hs3INvMWqPxzPoNYuFi5J+d6Vaz1dtqd9ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WLyFsQtk83ZRLjoojhlPgJ7CjUsIbNxWbVrLEY4v0/asqvU+6W7O9qCUfEjsyUlLx
	 qC5Y+HFZejM9WQE4S1HWi3LohUtnjsU2CJrk71QwHWjX51XJT8AnZ3uCthpRYtNMK6
	 iOmua/kHsZ1bylCn8Ki/mkZqwHTDf16TCRJE5fWEad8mlaJ6yek3qQJXIZb3326YJz
	 evmsx+pjW2Y6a33XvU3UbjvsQfmWR0qOaJhNqF5vydSXFh2THqOxIpq86GdP5neDeT
	 8Iq/ZFieXNvxsLuBol5ICD+3vp4hEX5ShtyNbHuD673EW68K8gBLHPEObjA1L7htB5
	 BIn3T6QpPA4xw==
Date: Mon, 06 Jul 2026 13:40:51 -1000
Message-ID: <476b6d543d0360f4eceb3badbe5d75e8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 28/36] sched_ext: Tie cpu occupancy to SCX_CAP_BASE through the task slice
In-Reply-To: <20260706020716.78CA41F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-29-tj@kernel.org> <20260706020716.78CA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:07:15 +0000, sashiko-bot wrote:
> - [High] Deferred out-of-band slice requests (slice_oob) are ignored and wiped when a task is dispatched or picked, leading to silent loss of the requested slice and potential soft lockups.

Confirmed, fixed for v3. set_next_task_scx() now flushes any pending
out-of-band request before evaluating CAN_STOP_TICK, and the flush is folded
into refill_task_slice_dfl() so every refill path applies a pending request
instead of wiping it.
