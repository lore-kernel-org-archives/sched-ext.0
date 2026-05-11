Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE437F8D7;
	Mon, 11 May 2026 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537041; cv=none; b=Dr3b4BK2MtAUNBCTgWSVb96/qb7eVDxhO0uOu3bZ9SgwUJ5WIRnQluwW523Om9lCN0g1Sj9xV3dQwae40RVTUuWsLZhNPGXaZC0x7ujIwkpP3KvmJtohXGphFYlJARRBrvB9/o8cM7Pq4oYiCaDVUQWMPQ8jF1rz+de/tcEwMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537041; c=relaxed/simple;
	bh=QUU6YKFS+cFfu3P41Qt/MqARzGzFR8ClRsYCYp+SFXo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=nm+UHnlqViv7ebZ1NTz5R04XZ5/AeajpNt9fdzhTJlsRn/W90ZKPkrtvZEudC6Ve/V8wx0XW27RxwKk0HHPSSHl8ptderR0EW3fgRJ8DN71SxCjO4q700dk2G8VaZGRL+3HL2p5IDqdoNMpWn+B4SCBwmlkeERMJABzMg7K1RKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9KnqRuH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9KnqRuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D156FC2BCB0;
	Mon, 11 May 2026 22:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778537041;
	bh=QUU6YKFS+cFfu3P41Qt/MqARzGzFR8ClRsYCYp+SFXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G9KnqRuHW7NEoJo0wLXuhZP+MWRBmD1GR261I2n/fWexqYSrMRIKoXWJbxgaUgx5t
	 augy7LRB3eAHpsvNCWeAiR9c8fZIXkgpGqj8M5yP4zmknpZRotI8jNadmKkaVJjLu6
	 rfF57XxoqEe0VXmHlDntrNPuXg0BW+OT+t5Az6UQss631vASh3MdnbZjte88y5ntWf
	 4hsm7UfOoguquMQY0e6//zYf6yqu67dUCQvsmvcFuH3PZ39Ok6bEReHf6Fs+zXkn55
	 7K125chX50SVUUHjjyt13O6V4QCdL6BLWvuA53uXIhJd4U4UzE+XDugahuX3yzpRaa
	 txWwRXy3Msozg==
Date: Mon, 11 May 2026 12:04:00 -1000
Message-ID: <8de51c6c723ee700fc655021a441bba9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Mark !CONFIG_EXT_SUB_SCHED
 dummy stubs static inline
In-Reply-To: <0d690b2a5b4497032ad19f61e4574566@kernel.org>
References: <0d690b2a5b4497032ad19f61e4574566@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
