<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<style>
    .update-content {
        padding-top: 36px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .box {
        margin: 16px 0 52px 0;
        width: 100%;
        max-width: 720px;
        border: 1px solid rgba(0,0,0,0.3);
        padding: 24px;
        border-radius: 8px;
    }

    .small-box {
        width: 100%;
        height: 52px;
        border-bottom: 1px solid rgba(0,0,0,0.1);
        padding: 15px 12px 16px 24px;
        display: flex;
        align-items: center;
        cursor: pointer;
    }

    .img-box {
        height: 93px;
        cursor: default;
    }

    .hint {
        width: 30%;
        min-width: 100px;
        max-width: 174px;
        font-size: 10px;
    }

    .privacy_detail {
        font-size: 14px;
        flex-grow: 1;
    }


</style>

<div class="main-content">
    <div class="update-content">
        <h4>개인정보</h4>

        <div class="box">
            <div class="small-box img-box">
                <span class="hint">사진</span>
                <div>
                    <c:choose>
                        <c:when test="${principal.user.image != null}">
                           <img src="${principal.user.image}" alt="profile"
                                class="update_profile_img target_img">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/image/user.png" alt="profile"
                                 class="update_profile_img target_img">
                        </c:otherwise>
                    </c:choose>
                    <input accept="image/jpeg, image/png" type = "file" id = "fileSelector" style = "display:none;">
                </div>
            </div>

            <div class="small-box mdc-ripple-surface" data-toggle="modal" data-target="#modifyName">
                <span class="hint">닉네임</span>
                <span class="privacy_detail">${principal.user.name}</span>
                <span class="material-icons md-16">chevron_right</span>
            </div>
            <div class="small-box mdc-ripple-surface">
                <span class="hint">이메일</span>
                <c:choose>
                    <c:when test="${principal.user.email == null}">
                        <span class="privacy_detail" style="opacity: .5">(설정 안함)</span>
                    </c:when>
                    <c:otherwise>
                        <span class="privacy_detail">${principal.user.email}</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="small-box mdc-ripple-surface" data-toggle="modal" data-target="#modifyAge">
                <span class="hint">나이</span>
                <c:choose>
                    <c:when test="${principal.user.ageRange == null}">
                        <span class="privacy_detail" style="opacity: .5">(설정 안함)</span>
                    </c:when>
                    <c:otherwise>
                        <span class="privacy_detail">${principal.user.ageRange}</span>
                    </c:otherwise>
                </c:choose>
                <span class="material-icons md-16">chevron_right</span>
            </div>
            <div class="small-box border-0 mdc-ripple-surface" data-toggle="modal" data-target="#modifyGender">
                <span class="hint">성별</span>
                <c:choose>
                    <c:when test="${principal.user.gender == 'female'}">
                        <span class="privacy_detail">여성</span>
                    </c:when>
                    <c:when test="${principal.user.gender == 'male'}">
                        <span class="privacy_detail">남성</span>
                    </c:when>
                    <c:otherwise>
                        <span class="privacy_detail" style="opacity: .5">(선택 안함)</span>
                    </c:otherwise>
                </c:choose>
                <span class="material-icons md-16">chevron_right</span>
            </div>
        </div>

        <c:choose>
            <c:when test="${myRoom.size() > 0}">
                <h4>참여한 토론</h4>

                <div class="container">
                    <div class="row">
                        <c:forEach items="${myRoom}" var="rooms">
                            <div class="col" style="display: flex; justify-content: center">
                                <div class="mdc-card mdc-card--outlined my-card" onclick="location.href = '/discuss/${rooms.roomId}'">
                                    <div class="mdc-card__primary-action my-card-content" tabindex="0">
                                        <c:choose>
                                            <c:when test="${roomList.opponent.id == null}">
                                                <sub>.</sub>
                                            </c:when>
                                            <c:when test="${roomList.startDebate == null}">
                                                <sub class="mdc-theme--error">준비중...</sub>
                                            </c:when>
                                            <c:otherwise>
                                                <sub>--명 시청 • ${roomList.startDebate}</sub>
                                            </c:otherwise>
                                        </c:choose>

                                        <br>
                                        <div class="my-card-body">
                                            <div class="contributors">
                                                <c:choose>
                                                    <c:when test="${rooms.owner.image != null}">
                                                        <img src="${rooms.owner.image}" class="profile">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/image/user.png" class="profile">
                                                    </c:otherwise>
                                                </c:choose>

                                            </div>
                                            <div class="contributors">
                                                <c:choose>
                                                    <c:when test="${rooms.opponent.id == null}">
                                                        <h2>대기</h2>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${rooms.opponent.image != null}">
                                                                <img src="${rooms.opponent.image}" class="profile">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${pageContext.request.contextPath}/image/user.png" class="profile">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="process_bar"><div class="process_left"></div></div>
                                        <div><sub>${rooms.roomCategory}</sub></div>
                                        <h5 class="font-weight-bold">(1-2) ${rooms.roomName}</h5>
                                        <div><sub>${rooms.createDate}</sub></div>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>

                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <h4 class="mdc-theme--error font-weight-bold">참여한 토론이 없습니다</h4>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../../component/dialog/nickname.jsp"%>
<%@ include file="../../component/dialog/age.jsp"%>
<%@ include file="../../component/dialog/gender.jsp"%>

<script>
    let updateForm_original_nick = "${principal.user.name}";
    let updateForm_original_age = "${principal.user.ageRange}";
    let updateForm_original_gender = "${principal.user.gender}";
</script>

<script src="${pageContext.request.contextPath}/js/user.js"></script>

<%@ include file="../layout/footer.jsp"%>